import tkinter as tk
from tkinter import ttk, messagebox
import os
import glob

def get_vm_list():
    """Retrieve available VMs in the main directory."""
    # Adjust file pattern based on your VM file type
    vm_files = glob.glob("*.img")  # Example: Find all .img files
    return [os.path.basename(vm) for vm in vm_files]

def update_vm_list():
    """Update the Treeview with VMs found in the main directory."""
    vm_list.delete(*vm_list.get_children())  # Clear list
    vms = get_vm_list()
    for vm in vms:
        vm_list.insert("", "end", values=(vm,))

def create_vm():
    """Create a new VM and update the list."""
    result = os.system("./diskimagecreator.sh")
    if result == 0:
        messagebox.showinfo("Success", "VM Created Successfully!")
        update_vm_list()
    else:
        messagebox.showerror("Error", "Failed to Create VM")

def delete_vm():
    """Notify user to manually delete the VM."""
    messagebox.showerror("Action Not Allowed", "Delete feature is not available. Manually remove the VM.")

def start_vm():
    """Start the VM and prevent multiple instances."""
    start_btn.config(state="disabled")  # Prevent multiple clicks
    result = os.system("./startvm.sh")
    if result == 0:
        messagebox.showinfo("VM Started", "Your VM is now running.")
    start_btn.config(state="normal")  # Re-enable button

def stop_vm():
    """Stop the VM and show a message."""
    result = os.system("./closevm.sh")
    if result == 0:
        messagebox.showinfo("VM Stopped", "The VM has been stopped successfully.")
    else:
        messagebox.showerror("Error", "Failed to stop VM.")

# Initialize main window
root = tk.Tk()
root.title("VM Manager")
root.geometry("500x400")

# Title Label
label = ttk.Label(root, text="Virtual Machine Manager", font=("Arial", 16, "bold"))
label.pack(pady=10)

# Frame for Buttons
frame = ttk.Frame(root)
frame.pack(pady=20)

# Buttons
create_btn = ttk.Button(frame, text="Create VM", command=create_vm)
delete_btn = ttk.Button(frame, text="Delete VM", command=delete_vm)
start_btn = ttk.Button(frame, text="Start VM", command=start_vm)
stop_btn = ttk.Button(frame, text="Stop VM", command=stop_vm)

# Grid layout for buttons
create_btn.grid(row=0, column=0, padx=10, pady=10)
delete_btn.grid(row=0, column=1, padx=10, pady=10)
start_btn.grid(row=1, column=0, padx=10, pady=10)
stop_btn.grid(row=1, column=1, padx=10, pady=10)

# VM List
vm_list = ttk.Treeview(root, columns=("#1",), show="headings", height=8)
vm_list.heading("#1", text="Virtual Machines")
vm_list.pack(pady=20, fill=tk.BOTH, expand=True)

# Populate VM list on startup
update_vm_list()

# Run the application
root.mainloop()
