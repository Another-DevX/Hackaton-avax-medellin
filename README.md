<h1 align="center">Hyper vault 💸</h1>
<div><p>A blockchain standard for transfer and manage tokens using Teleporter in subnets, Avalanche network ⚡️.</p></div>
<div>
<h2>¿Qué es Hyper vault?</h2>
<img src="/public/portada.png" width="400" />
<p>Es una herramienta que permite el envío de mensajes de valor entre subnets y mantiene un estado unificado en la <i>primary network.</i></p>
<p>Hyper vault soluciona principalmente la transferencia de mensajes que representan activos digitales resguardados en la c-chain (la red principal y más segura). Usamos perfectamente una implementación escalable de WARP usando la interfaz de teleporter y unas configuraciones de x-chain.</p>
<h2>¿Cómo funciona Hyper vault?</h2>
<img src="/public/workflow.jpg" />
<p>En resumen, la implementación de nuestra aplicación se basa en dos contratos principales: <i>hyper-vault y hyper-vault manager</i>.

1. El contrato <i>hyper-vault</i> es el contrato principal que maneja toda la liquidez del protocolo, en él se encuentran las principales transacciones que pertenecen a los diferentes usuarios y dApps.

2. El contrato <i>hyper-vault manager</i> se encarga de administrar las peticiones hacia el contrato principal. Contiene las funciones de "verificación" y callbacks que proporcionan una respuesta sencilla: tiene fondos o no. 

Este segundo contrato es sumamente importante por la capa de seguridad que le proporciona a la aplicación.</p>
</div>