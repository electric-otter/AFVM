chmod -R +x ./graphics ./hypervisor
find ./graphics -type f -exec xdg-open {} \; &
find ./hypervisor -type f -exec xdg-open {} \; &
find ./graphics -type f -executable -exec {} \;
find ./hypervisor -type f -executable -exec {} \;
