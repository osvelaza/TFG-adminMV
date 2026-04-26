import sys
import os
from PySide6.QtCore import QProcess
from PySide6.QtWidgets import QMessageBox, QApplication, QCheckBox
import utils

def launchPacker(window):
    #Copia y edita las plantillas Packer a otro directorio
    ruta=utils.editPackerHcl(window)

    print(ruta)

    window.logger.clear()
    process = QProcess()
    process.readyReadStandardOutput.connect(
        lambda: comprobLinea(window,
            process.readAllStandardOutput().data().decode().rstrip()
        )
    )
    process.readyReadStandardError.connect(
        lambda: comprobLinea(window,
            process.readAllStandardError().data().decode().rstrip()
        )
    )

    #rutaQCow2=os.path.dirname(ruta)+"/output/ubuntu.qcow2"         #Cambiar

    #process.finished.connect(launchVirsh(rutaQCow2))

    CreVM=window.findChild(QCheckBox, 'boolCrear')
    boolCreVM=CreVM.isChecked()

    # Iniciar el proceso
    rutaComp=os.path.abspath(ruta)
    print(rutaComp)
    print(boolCreVM)
    window.estadoBuild.setStyleSheet("""background-color: #FFDE21;""")
    process.start("bash", [rutaComp,os.path.dirname(ruta),str(boolCreVM)])
    

def comprobLinea(window,linea):
    window.logger.appendPlainText(linea)
    if "Builds finished" in linea:
        print("encontrado")
        window.estadoBuild.setStyleSheet("""background-color: #21ff34;""")

def launchVirsh(ruta):
    print("FUNCIONA "+ruta)
    #subprocess.call(["bash", "../newTes/fedora42server/virsh.sh"])
#def virshFedSer43():
#    subprocess.call(["bash", "../newTes/fedora42server/virsh.sh"])

def startVM(domainvm,window):
    utils.run(["bash","../newTes/virshManageStart.sh",str(domainvm)])
    #guestInfo(window)

def stopVM(domainvm,window):
    utils.run(["bash","../newTes/virshManageStop.sh",str(domainvm)])
    #guestInfo(window)