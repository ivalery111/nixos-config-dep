# nixos-config

This project aims to create a nix configuration file with modules and services. It will let to reproduce the workstation in a fast way.
Also, I"ll define a nix-shells development environment to create a virtual one for any purpose that I will need.  

---

### Usage:  

#### NixOS Configuration:

Download this repository and locate into '/etc/nixos/'.  
In '/etc/nixos/configuration.nix' add the path to 'standart-configuration.nix'
```
    imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nixos-config/standart-config.nix
    ];
```  
#### Nix-Shell:

nix-shell's are defines in folder 'nix-shells'. These shells allow you to create an isolated development environment. It is very useful when important for portability.  
* c-env.nix - nix-shell for C programming.  

---

## Contributing

Feel free open the issue, PR or send me e-mail. Thank you!  

---

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

## Contact

Valery - ivalery111[[@]]gmail.com  

---  
