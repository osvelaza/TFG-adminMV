# TFG-adminMV
Este administrador de máquinas virtuales facilita la creación de máquinas virtuales haciendo que su instalación sea automática, ya que solo es necesario elejir cual es la distribución y su version. El programa de forma automática descarga la ISO e inicia la instalación.
-----
## Requisitos prévios
- **Python**: La interfaz gráfica está escrita en python. Suele venir preinstalado en la mayoría de distribuciones. Para comprobarlo, ejecutar el siguiente comando:
```bash
python -V
```
Si devuelve la versión del programa, lo tiene instalado y puede continuar, en caso negativo, debe instalarlo con el gestor de paquetes de su distribución.
- **BASH**: Interprete de línea de comandos
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Gnu-bash-logo.svg/3840px-Gnu-bash-logo.svg.png" alt="Logo BASH" width="300" height="200">
</p>

- **QEMU/KVM**: Es el hypervisor elejido para el programa
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Qemu_logo.svg/1280px-Qemu_logo.svg.png" alt="Logo QEMU" width="300" height="200">
</p>

- **virsh**: Una interfaz de línea de comandos para KVM

-----

## Instalacion
En la raiz del proyecto hay un pequeño script BASH que facilita la instalación de este programa ```habiendo cumplido los requisitos```
Para ejecutarlo, hay que ejecutar el comando:
```bash
curl -sSL https://raw.githubusercontent.com/osvelaza/TFG-adminMV/refs/heads/main/install.sh | bash
```

El script descarga este repositorio Github y crea un acceso directo en el menú de aplicaciones
