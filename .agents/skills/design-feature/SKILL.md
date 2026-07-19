---
name: design-feature
description: >
  Diseña una feature de forma completa, explícita y verificable antes de
  planificar su implementación. Convierte una capacidad del alcance en
  comportamiento concreto: actores, flujos, reglas, permisos, estados,
  errores, criterios de aceptación, testing y slices candidatos. No implementa
  código ni elige stack. Úsala cuando la feature esté en alcance aprobado y
  necesite una especificación usable por varios agentes. Produce
  docs/features/<feature>/spec.md, test-plan.md y open-questions.md, con gate
  (READY FOR PLANNING, CONDITIONALLY READY, DESIGN REVIEW REQUIRED, REFINEMENT
  REQUIRED, MORE EVIDENCE REQUIRED, ARCHITECTURE INPUT REQUIRED, BLOCKED).
---

# design-feature

## Propósito

Diseñar una feature de forma completa, explícita y verificable antes de planificar su implementación.

Esta skill transforma una capacidad incluida en el alcance del producto en una especificación funcional suficientemente precisa para que distintos agentes puedan:

* comprender el problema;
* evaluar el comportamiento esperado;
* detectar ambigüedades;
* revisar riesgos;
* definir criterios de aceptación;
* preparar posteriormente un plan de ejecución;
* dividir el trabajo en vertical slices.

La especificación debe describir qué debe ocurrir, para quién, bajo qué reglas y cómo se comprobará.

No debe convertir prematuramente decisiones de producto en decisiones técnicas irreversibles.

---

## Compatibilidad

Esta skill es agnóstica al modelo, proveedor y herramienta.

Puede ser utilizada por:

* Codex;
* OpenCode;
* Claude Code;
* Grok;
* Kimi;
* DeepSeek;
* agentes personalizados;
* cualquier agente capaz de leer y escribir documentación del repositorio.

La fuente de verdad es el repositorio, no el historial del chat ni la memoria del modelo.

---

## Cuándo utilizarla

Utilizar esta skill cuando:

* la feature forme parte de un alcance aprobado o condicionalmente aprobado;
* exista un problema y resultado esperado suficientemente definidos;
* sea necesario convertir una capacidad general en comportamiento concreto;
* múltiples personas o agentes puedan interpretar la feature de manera diferente;
* la feature afecte permisos, datos, estados, integraciones o flujos relevantes;
* se necesiten criterios de aceptación antes de crear un `ExecPlan`;
* una feature existente deba ser rediseñada o ampliada.

No utilizarla para:

* descubrir el producto completo;
* validar demanda de mercado;
* seleccionar arquitectura general;
* crear tareas técnicas detalladas;
* implementar código;
* aprobar automáticamente una feature todavía ambigua.

---

## Entradas esperadas

Revisar, cuando existan:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* documentación de descubrimiento;
* resultados de validación;
* arquitectura de información;
* atributos de calidad;
* documentación de features relacionadas;
* decisiones registradas;
* auditoría del proyecto existente;
* evidencia de usuarios;
* requisitos legales, operativos o comerciales;
* comportamiento actual del sistema.

Si la feature modifica comportamiento existente, inspeccionar también:

* flujos actuales;
* contratos públicos;
* permisos;
* estados;
* métricas;
* tests existentes;
* incidencias conocidas;
* dependencias activas.

No asumir que una solicitud aislada representa automáticamente el comportamiento correcto.

---

## Entregables

Crear o actualizar:

```text
docs/features/<feature-name>/
├── spec.md
├── test-plan.md
└── open-questions.md
```

`spec.md` debe contener la definición estable de producto y comportamiento.

`test-plan.md` debe contener la estrategia de verificación derivada de la especificación.

`open-questions.md` debe contener únicamente dudas, decisiones pendientes, supuestos y riesgos no resueltos.

Si el proyecto utiliza otra estructura documental, respetarla sin duplicar fuentes de verdad.

Actualizar `docs/project-status.md` cuando la feature cambie de gate, introduzca bloqueantes o determine la siguiente skill recomendada.

---

## Principios

### Diseñar comportamiento, no pantallas aisladas

Una feature no es solamente una interfaz, endpoint, tabla o componente.

Debe diseñarse como un comportamiento completo que incluya, cuando aplique:

* intención del usuario;
* interacción;
* reglas;
* datos;
* permisos;
* estados;
* errores;
* feedback;
* operaciones;
* medición;
* verificación.

### Separar hechos, decisiones y supuestos

Clasificar explícitamente cada afirmación relevante como:

* evidencia;
* requisito confirmado;
* decisión;
* supuesto;
* restricción;
* preferencia;
* pregunta abierta.

No ocultar incertidumbre mediante lenguaje definitivo.

### Mantener neutralidad tecnológica

La especificación puede describir:

* responsabilidades;
* contratos conceptuales;
* eventos de negocio;
* datos requeridos;
* consistencia esperada;
* tiempos de respuesta necesarios;
* comportamiento ante fallos.

No debe seleccionar prematuramente:

* frameworks;
* librerías;
* bases de datos;
* proveedores;
* patrones arquitectónicos;
* servicios externos;
* formatos internos definitivos.

Las restricciones tecnológicas ya aprobadas pueden documentarse como contexto, pero no rediseñarse dentro de esta skill.

### Diseñar el mínimo comportamiento completo

Evitar tanto:

* especificaciones vagas que obliguen al implementador a inventar el producto;
* especificaciones sobredimensionadas que anticipen necesidades no confirmadas.

---

## Procedimiento

## 1. Identificar la feature

Definir:

* nombre;
* estado;
* responsable de producto;
* documento de alcance que la autoriza;
* incremento al que pertenece;
* fecha o condición de revisión;
* features relacionadas;
* sistemas o procesos afectados.

Asignar un estado inicial:

* `Draft`;
* `In Design`;
* `Ready for Review`;
* `Approved`;
* `Conditionally Approved`;
* `Blocked`;
* `Superseded`.

---

## 2. Definir el problema

Explicar:

* qué problema existe;
* quién lo experimenta;
* en qué contexto;
* cómo se resuelve actualmente;
* qué limitación tiene la situación actual;
* qué evidencia respalda su relevancia;
* qué ocurre si no se resuelve.

Evitar formular el problema como una solución.

Incorrecto:

> El usuario necesita un botón para exportar.

Preferible:

> El operador necesita compartir periódicamente información fuera del sistema sin copiar cada registro manualmente.

---

## 3. Definir el resultado esperado

Describir el cambio observable que la feature debe producir.

Debe indicar:

* actor beneficiado;
* capacidad obtenida;
* resultado funcional;
* señal de éxito;
* límites del resultado.

Distinguir entre:

* output: lo que el sistema entrega;
* outcome: lo que el usuario logra;
* impacto: cambio posterior esperado en el producto o negocio.

No prometer impacto que no pueda atribuirse o medirse razonablemente.

---

## 4. Identificar usuarios y actores

Documentar todos los actores relevantes:

* usuario primario;
* usuarios secundarios;
* administradores;
* operadores;
* soporte;
* moderadores;
* sistemas externos;
* procesos automatizados;
* actores no autenticados;
* terceros afectados.

Para cada actor indicar:

* objetivo;
* contexto;
* nivel de conocimiento;
* frecuencia de uso;
* permisos esperados;
* riesgos;
* necesidades de accesibilidad;
* relación con los datos.

No tratar a “el usuario” como una entidad única cuando existen roles diferentes.

---

## 5. Definir alcance

Separar claramente:

### Dentro del alcance

Comportamientos que esta feature debe soportar.

### Fuera del alcance

Comportamientos relacionados que no forman parte de esta entrega.

### No objetivos

Resultados que deliberadamente no se intentan conseguir.

### Trabajo futuro posible

Ideas plausibles que no constituyen compromisos.

### Comportamiento existente que no debe cambiar

Contratos o flujos que deben preservarse.

Todo elemento incluido debe contribuir al resultado esperado o a una restricción necesaria.

---

## 6. Definir precondiciones y postcondiciones

Para cada flujo relevante indicar:

### Precondiciones

* autenticación;
* permisos;
* datos previos;
* estado requerido;
* configuración;
* dependencias disponibles;
* consentimiento;
* conectividad;
* requisitos legales u operativos.

### Postcondiciones exitosas

* estado final;
* datos creados o modificados;
* efectos visibles;
* efectos secundarios;
* notificaciones;
* trazabilidad;
* métricas registradas.

### Postcondiciones ante fallo

* qué permanece sin cambios;
* qué puede quedar parcialmente procesado;
* qué debe revertirse;
* qué puede reintentarse;
* qué se informa al usuario;
* qué debe registrarse para soporte.

---

## 7. Diseñar los flujos

Describir el flujo principal de punta a punta.

Cada paso debe indicar:

* actor;
* intención;
* acción;
* respuesta del sistema;
* datos utilizados;
* decisión;
* transición de estado;
* feedback;
* posible interrupción.

Diseñar también:

### Flujos alternativos

Variantes válidas del comportamiento principal.

### Flujos de excepción

Casos en los que una regla, permiso, dependencia o validación impide continuar.

### Flujos de recuperación

Cómo puede el usuario o sistema recuperarse de errores, interrupciones o estados parciales.

### Flujos operativos

Cómo soporte, administración o moderación observan, corrigen o intervienen.

### Flujos de cancelación

Qué ocurre si el usuario abandona, cancela o retrocede.

No limitar la especificación al happy path.

---

## 8. Definir reglas de negocio

Registrar cada regla con un identificador estable.

Ejemplo:

```text
BR-001
```

Para cada regla indicar:

* descripción;
* razón;
* actores afectados;
* datos necesarios;
* momento de evaluación;
* excepciones;
* comportamiento ante incumplimiento;
* autoridad que puede modificarla;
* evidencia o decisión que la respalda.

Distinguir entre:

* reglas de producto;
* políticas operativas;
* restricciones legales;
* validaciones de formato;
* decisiones temporales;
* limitaciones técnicas existentes.

No convertir una limitación accidental del sistema actual en regla de negocio sin justificación.

---

## 9. Definir roles, permisos y ownership

Construir una matriz que relacione:

* actor;
* recurso;
* acción;
* condición;
* resultado permitido;
* resultado denegado;
* trazabilidad requerida.

Cubrir, cuando aplique:

* crear;
* leer;
* listar;
* buscar;
* editar;
* eliminar;
* restaurar;
* aprobar;
* rechazar;
* publicar;
* archivar;
* transferir;
* exportar;
* compartir;
* administrar;
* impersonar;
* ejecutar acciones masivas.

Definir ownership:

* quién posee el recurso;
* quién puede administrarlo;
* si pertenece a una persona, organización, tenant, comercio, proyecto u otra entidad;
* qué ocurre cuando cambia el propietario;
* qué ocurre cuando un usuario pierde acceso;
* qué permisos se heredan;
* qué permisos requieren asignación explícita.

Aplicar principio de mínimo privilegio.

Una interfaz oculta no constituye control de acceso.

---

## 10. Modelar estados y transiciones

Identificar todas las entidades o procesos con ciclo de vida.

Para cada uno definir:

* estados posibles;
* estado inicial;
* estados terminales;
* transiciones permitidas;
* actor autorizado;
* condición;
* efectos;
* reversibilidad;
* expiración;
* transición automática;
* transición inválida;
* comportamiento ante concurrencia.

Representar el ciclo de vida mediante tabla o diagrama textual.

Ejemplo conceptual:

```text
Draft
  → Pending Review
  → Approved
  → Published
  → Archived
```

No utilizar un único campo genérico cuando existan dimensiones independientes, por ejemplo:

* estado editorial;
* estado de pago;
* estado de moderación;
* disponibilidad;
* visibilidad.

Identificar estados imposibles o contradictorios.

---

## 11. Definir validaciones

Separar:

### Validaciones de entrada

Formato, longitud, tipo, obligatoriedad y estructura.

### Validaciones de negocio

Condiciones derivadas de reglas, permisos, estados o límites.

### Validaciones contextuales

Dependencias con otros recursos, fechas, ubicación, disponibilidad o configuración.

### Validaciones de seguridad

Acceso, integridad, ownership, contenido no permitido y exposición de datos.

### Validaciones de concurrencia

Cambios simultáneos, duplicados, repetición de acciones y datos desactualizados.

Para cada validación indicar:

* momento;
* autoridad;
* mensaje esperado;
* posibilidad de corrección;
* persistencia parcial;
* código o categoría conceptual del error;
* comportamiento para integraciones.

No depender únicamente de validación en interfaz.

---

## 12. Diseñar errores y recuperación

Clasificar errores:

* entrada inválida;
* permiso insuficiente;
* recurso inexistente;
* conflicto;
* estado incompatible;
* dependencia no disponible;
* timeout;
* límite superado;
* duplicado;
* operación parcial;
* error inesperado;
* restricción legal o comercial.

Para cada categoría definir:

* mensaje para el usuario;
* acción posible;
* posibilidad de reintento;
* preservación de datos;
* logging;
* correlación para soporte;
* severidad;
* necesidad de alerta;
* impacto sobre métricas.

Los mensajes deben:

* explicar qué ocurrió;
* evitar culpar al usuario;
* indicar cómo continuar;
* no revelar información sensible;
* ser consistentes entre canales.

---

## 13. Diseñar estados de interfaz y feedback

Para cada superficie afectada especificar:

### Loading

* qué se está esperando;
* si bloquea toda la interfaz o una sección;
* si existe progreso conocido;
* si la acción puede cancelarse;
* prevención de acciones duplicadas;
* tiempo tras el cual debe mostrarse información adicional.

### Empty

Distinguir entre:

* usuario nuevo;
* búsqueda sin resultados;
* filtros sin coincidencias;
* contenido eliminado;
* contenido todavía no disponible;
* falta de permisos;
* error interpretado erróneamente como vacío.

Cada estado vacío debe ofrecer una acción relevante cuando exista.

### Error

Indicar:

* qué información se conserva;
* si puede reintentarse;
* cómo volver a un estado seguro;
* cuándo contactar soporte.

### Unauthorized

Distinguir entre:

* no autenticado;
* autenticado sin permiso;
* acceso expirado;
* recurso de otro owner;
* plan insuficiente;
* cuenta suspendida;
* restricción geográfica o legal.

No revelar la existencia de recursos cuando ello genere riesgo de seguridad.

### Success

Indicar:

* confirmación;
* estado resultante;
* siguiente acción;
* persistencia del feedback;
* comportamiento si la operación continúa en segundo plano.

### Partial success

Diseñar explícitamente operaciones donde solo una parte puede completarse.

---

## 14. Identificar edge cases

Evaluar, cuando sean relevantes:

* datos inexistentes;
* datos incompletos;
* valores mínimos y máximos;
* fechas límite;
* zonas horarias;
* cambios de horario;
* localización;
* idiomas;
* caracteres especiales;
* contenido muy largo;
* archivos grandes;
* conexiones lentas;
* pérdida de conexión;
* doble envío;
* reintentos;
* refresh;
* navegación hacia atrás;
* múltiples pestañas;
* concurrencia;
* cambios simultáneos;
* recursos eliminados durante el flujo;
* permisos revocados;
* sesiones expiradas;
* cuentas suspendidas;
* dependencias degradadas;
* importaciones parciales;
* duplicados;
* datos históricos;
* relaciones huérfanas;
* recuperación después de fallo;
* abuso;
* fraude;
* spam;
* automatizaciones;
* uso masivo;
* usuarios sin experiencia;
* usuarios que utilizan tecnologías asistivas.

No es necesario soportar todos los casos, pero cada exclusión importante debe ser explícita.

---

## 15. Accesibilidad

Definir requisitos funcionales de accesibilidad sin atarlos a una librería.

Cubrir, cuando aplique:

* navegación por teclado;
* orden de foco;
* foco visible;
* retorno de foco;
* etiquetas accesibles;
* nombres y roles;
* mensajes de error asociados;
* anuncios de cambios dinámicos;
* contraste;
* ampliación de texto;
* reducción de movimiento;
* contenido no dependiente solo del color;
* objetivos táctiles adecuados;
* subtítulos o alternativas;
* lenguaje claro;
* tiempo suficiente;
* prevención de pérdida de datos;
* compatibilidad con tecnologías asistivas.

Identificar criterios de accesibilidad que formen parte de la aceptación y testing.

No tratar accesibilidad como mejora opcional posterior.

---

## 16. Responsive y contextos de uso

Definir cómo debe adaptarse la feature a:

* viewport pequeño;
* viewport mediano;
* viewport grande;
* orientación vertical y horizontal;
* interacción táctil;
* teclado y mouse;
* baja conectividad;
* dispositivos de menor capacidad;
* contenido variable;
* zoom;
* densidad alta de datos.

Describir prioridades de contenido y comportamiento, no dimensiones técnicas prematuras.

Indicar:

* qué contenido se conserva;
* qué se reorganiza;
* qué puede colapsarse;
* qué nunca debe ocultarse;
* qué acciones deben permanecer accesibles;
* cómo se evita pérdida de contexto.

---

## 17. Métricas y analytics

Definir qué preguntas deben responderse después del lanzamiento.

Ejemplos:

* ¿Los usuarios encuentran la feature?
* ¿Inician el flujo?
* ¿Lo completan?
* ¿Dónde abandonan?
* ¿Qué errores encuentran?
* ¿Repiten el comportamiento?
* ¿El resultado esperado ocurre?
* ¿La feature genera efectos adversos?

Definir:

* métrica principal;
* métricas secundarias;
* guardrails;
* segmentos;
* embudo;
* periodo de observación;
* baseline;
* criterio de éxito;
* criterio de alerta.

Para cada evento conceptual de analytics indicar:

* nombre semántico;
* momento;
* actor;
* propiedades mínimas;
* datos prohibidos;
* finalidad;
* política de deduplicación;
* relación con consentimiento y privacidad.

No capturar datos sensibles por conveniencia.

Distinguir analytics de producto, observabilidad técnica y auditoría.

---

## 18. Datos preliminares

Definir los conceptos de datos necesarios sin diseñar todavía un esquema definitivo.

Para cada entidad conceptual indicar:

* propósito;
* owner;
* atributos mínimos;
* relaciones;
* ciclo de vida;
* origen;
* autoridad;
* sensibilidad;
* retención;
* mutabilidad;
* auditabilidad;
* reglas de integridad;
* posibilidad de eliminación;
* necesidad de historial.

Clasificar datos, cuando aplique:

* públicos;
* internos;
* confidenciales;
* personales;
* sensibles;
* derivados;
* operativos;
* efímeros;
* auditables.

Identificar:

* fuente de verdad;
* datos calculados;
* datos duplicados;
* datos importados;
* sincronización;
* resolución de conflictos;
* consistencia esperada.

No definir tablas, índices ni tipos específicos salvo que ya sean una restricción aprobada.

---

## 19. Contratos preliminares

Describir contratos de comportamiento entre:

* usuario y sistema;
* frontend y backend;
* módulos;
* servicios;
* integraciones externas;
* procesos asíncronos;
* operadores y sistema.

Cada contrato conceptual debe incluir:

* intención;
* entrada;
* salida;
* precondiciones;
* errores;
* permisos;
* idempotencia;
* orden;
* consistencia;
* versionado esperado;
* límites;
* privacidad.

No seleccionar necesariamente:

* protocolo;
* formato de serialización;
* transporte;
* proveedor;
* librería.

Si ya existe un contrato público, documentar compatibilidad y estrategia de evolución.

---

## 20. Dependencias

Identificar dependencias:

* de producto;
* de UX;
* de datos;
* de permisos;
* de arquitectura;
* de infraestructura;
* de terceros;
* legales;
* comerciales;
* operativas;
* de contenido;
* de soporte;
* de otras features;
* de migraciones.

Para cada dependencia indicar:

* owner;
* estado;
* criticidad;
* alternativa;
* impacto si falla;
* posibilidad de desacoplamiento;
* decisión pendiente;
* evidencia disponible.

Distinguir entre dependencia obligatoria y conveniencia.

---

## 21. Riesgos

Crear un registro de riesgos específico de la feature.

Categorías posibles:

* valor;
* usabilidad;
* accesibilidad;
* seguridad;
* privacidad;
* fraude;
* abuso;
* integridad de datos;
* concurrencia;
* cumplimiento;
* operación;
* soporte;
* dependencia externa;
* rendimiento;
* escalabilidad;
* adopción;
* compatibilidad;
* migración;
* rollout;
* reversibilidad.

Para cada riesgo indicar:

* descripción;
* probabilidad;
* impacto;
* señal temprana;
* mitigación;
* contingencia;
* owner;
* riesgo residual;
* necesidad de aprobación humana.

Los riesgos críticos no resueltos deben afectar el gate final.

---

## 22. Rollout

Diseñar cómo introducir la feature de forma controlada.

Evaluar:

* lanzamiento interno;
* entorno de preview;
* usuarios piloto;
* segmentos;
* allowlist;
* activación gradual;
* convivencia con comportamiento anterior;
* migración progresiva;
* comunicación;
* soporte;
* documentación;
* capacitación;
* medición;
* criterios de expansión;
* criterios de pausa.

Definir:

* quién puede activarla;
* para quién;
* en qué orden;
* qué evidencia habilita avanzar;
* qué señales obligan a detenerse;
* qué dependencia debe estar operativa;
* cómo verificar el estado después del despliegue.

No asumir que toda feature debe lanzarse globalmente en una única operación.

---

## 23. Rollback y reversibilidad

Definir qué significa revertir la feature.

Distinguir entre:

* desactivar exposición;
* volver al comportamiento anterior;
* detener procesamiento;
* revertir datos;
* compensar efectos;
* restaurar compatibilidad;
* comunicar incidentes.

Documentar:

* disparadores;
* autoridad;
* tiempo objetivo;
* datos que pueden perderse;
* datos que no deben revertirse;
* operaciones irreversibles;
* compatibilidad hacia atrás;
* estrategia para recursos creados durante el rollout;
* verificación posterior.

Si el rollback completo no es posible, declararlo explícitamente y diseñar contingencias.

---

## 24. Criterios de aceptación

Crear criterios observables, verificables y no ambiguos.

Cada criterio debe:

* tener identificador;
* referenciar actor o sistema;
* indicar precondición;
* describir acción;
* definir resultado;
* incluir restricciones;
* poder comprobarse.

Formato recomendado:

```text
AC-001

Given:
When:
Then:
And:
```

Cubrir:

* flujo principal;
* flujos alternativos;
* permisos;
* ownership;
* estados;
* validaciones;
* errores;
* loading;
* empty;
* unauthorized;
* accesibilidad;
* responsive;
* analytics;
* concurrencia;
* recuperación;
* rollout;
* compatibilidad.

Evitar criterios como:

* “funciona correctamente”;
* “es intuitivo”;
* “es responsive”;
* “maneja errores”;
* “tiene buena performance”.

Convertirlos en comportamientos comprobables.

---

## 25. Estrategia de testing

Derivar el plan de testing directamente de riesgos, reglas y criterios de aceptación.

Definir:

### Tests de comportamiento

Verifican resultados observables del usuario o sistema.

### Tests de reglas

Cubren reglas de negocio, límites y excepciones.

### Tests de permisos

Cubren acciones permitidas, denegadas y aislamiento entre owners o tenants.

### Tests de estados

Cubren transiciones válidas, inválidas, automáticas y concurrentes.

### Tests de validación

Cubren valores válidos, inválidos y límites.

### Tests de integración

Cubren contratos entre componentes o sistemas.

### Tests end-to-end

Cubren los journeys críticos de punta a punta.

### Tests de accesibilidad

Cubren navegación, foco, semántica, errores y tecnologías asistivas.

### Tests responsive

Cubren prioridades de contenido e interacción en contextos relevantes.

### Tests de resiliencia

Cubren fallos, timeouts, reintentos, operaciones parciales y recuperación.

### Tests de seguridad

Cubren autorización, exposición de datos, abuso y manipulación de entradas.

### Tests de migración o compatibilidad

Cubren datos existentes y comportamiento anterior.

### Tests de observabilidad y analytics

Verifican eventos, ausencia de datos prohibidos y señales operativas.

Para cada área indicar:

* riesgo cubierto;
* nivel recomendado;
* datos necesarios;
* ambiente;
* criterio de éxito;
* evidencia esperada.

No exigir una pirámide de testing universal. Elegir niveles según el comportamiento y riesgo.

---

## 26. Preparar descomposición en vertical slices

No crear todavía el `ExecPlan`, pero proponer una descomposición candidata.

Cada vertical slice debe:

* entregar comportamiento verificable;
* atravesar las capas necesarias;
* incluir permisos;
* incluir datos mínimos;
* incluir manejo de errores;
* incluir tests;
* poder integrarse;
* reducir riesgo o incertidumbre;
* evitar depender de una entrega masiva final.

Para cada slice candidato indicar:

* resultado;
* actor;
* flujo cubierto;
* reglas incluidas;
* datos mínimos;
* dependencias;
* criterios de aceptación;
* tests necesarios;
* riesgos;
* qué queda explícitamente fuera.

Ordenar los slices considerando:

1. incertidumbre;
2. valor;
3. riesgo;
4. dependencias;
5. capacidad de integración;
6. reversibilidad.

No dividir exclusivamente por capas técnicas como:

* frontend;
* backend;
* base de datos;
* tests.

---

## 27. Revisar consistencia

Antes del gate final comprobar:

* ¿El problema coincide con el alcance?
* ¿El resultado puede alcanzarse con lo incluido?
* ¿Los no objetivos evitan interpretaciones amplias?
* ¿Los flujos cubren happy path y excepciones?
* ¿Cada regla aparece reflejada en criterios de aceptación?
* ¿Los permisos coinciden con el ownership?
* ¿Los estados permiten todos los flujos válidos?
* ¿Las validaciones son coherentes entre canales?
* ¿Los errores permiten recuperación?
* ¿Loading, empty, error y unauthorized están diferenciados?
* ¿Los edge cases críticos tienen decisión?
* ¿Accesibilidad y responsive son verificables?
* ¿Las métricas responden preguntas reales?
* ¿Los datos tienen owner y ciclo de vida?
* ¿Los contratos pueden evolucionar?
* ¿Las dependencias bloqueantes están identificadas?
* ¿Los riesgos tienen tratamiento?
* ¿El rollout tiene señales de avance y pausa?
* ¿El rollback es realista?
* ¿Los criterios pueden convertirse en tests?
* ¿La feature puede dividirse en vertical slices?

---

## 28. Revisión adversarial

Intentar refutar el diseño.

Preguntar:

* ¿La feature resuelve el problema o solo implementa una solicitud?
* ¿Existe una solución más simple?
* ¿Se introducen capacidades sin evidencia?
* ¿Se está diseñando para usuarios inexistentes?
* ¿Se mezclaron varias features bajo un único nombre?
* ¿El flujo depende de trabajo manual no documentado?
* ¿Un actor puede obtener o modificar datos que no le pertenecen?
* ¿Existe un estado imposible?
* ¿Una operación repetida produce duplicados?
* ¿Qué ocurre si la dependencia externa falla después de un efecto parcial?
* ¿El usuario puede perder trabajo?
* ¿La feature puede abusarse?
* ¿El analytics viola privacidad?
* ¿El sistema puede soportarla operativamente?
* ¿Puede lanzarse de forma gradual?
* ¿Puede detenerse sin dañar datos?
* ¿Los criterios de aceptación permiten interpretaciones distintas?
* ¿El implementador deberá inventar comportamiento no especificado?

Registrar hallazgos y resolverlos o convertirlos en preguntas abiertas.

---

## Gates

Asignar uno de los siguientes resultados.

### READY FOR PLANNING

La feature tiene:

* problema y resultado claros;
* alcance y no objetivos explícitos;
* flujos completos;
* reglas coherentes;
* permisos y ownership definidos;
* estados y transiciones válidos;
* errores y edge cases críticos resueltos;
* criterios verificables;
* estrategia de testing;
* dependencias conocidas;
* rollout y rollback viables;
* descomposición candidata en vertical slices.

Puede continuar a `create-exec-plan`.

### CONDITIONALLY READY FOR PLANNING

La feature puede planificarse, pero existen:

* supuestos aceptados;
* decisiones menores pendientes;
* dependencias no bloqueantes;
* riesgos residuales explícitos.

Las condiciones deben quedar registradas con owner y fecha o condición de resolución.

### DESIGN REVIEW REQUIRED

La especificación está completa para ser revisada, pero todavía necesita una revisión independiente mediante `review-feature`.

Este gate es apropiado cuando el agente autor no debe aprobar su propio diseño.

### REFINEMENT REQUIRED

Existen ambigüedades, contradicciones, reglas incompletas o criterios insuficientes.

No debe iniciarse el plan de implementación.

### MORE EVIDENCE REQUIRED

Una decisión central depende de evidencia de producto, usabilidad, operación o viabilidad todavía insuficiente.

Debe volver a validación, descubrimiento o un experimento.

### ARCHITECTURE INPUT REQUIRED

El comportamiento está claro, pero una decisión depende de:

* atributos de calidad;
* restricción sistémica;
* spike;
* contrato compartido;
* capacidad arquitectónica todavía no definida.

No seleccionar una tecnología dentro de esta skill para cerrar artificialmente el bloqueo.

### BLOCKED

Faltan decisiones, autoridad, información, acceso o dependencias indispensables.

### NOT READY FOR IMPLEMENTATION

Puede existir documentación parcial, pero no hay condiciones para implementar de forma segura.

Este gate puede acompañar cualquiera de los estados que requieran trabajo adicional.

---

## Criterios mínimos para implementación

Una feature no está lista para implementación solamente porque exista una descripción general.

Como mínimo debe tener:

* alcance aprobado;
* no objetivos;
* actores;
* flujo principal;
* flujos alternativos críticos;
* reglas;
* permisos;
* ownership;
* estados;
* validaciones;
* errores;
* criterios de aceptación;
* riesgos;
* estrategia de testing;
* dependencias;
* rollout;
* rollback o contingencia;
* revisión independiente cuando corresponda;
* plan de ejecución aprobado.

La implementación debe comenzar después de `create-exec-plan`, salvo cambios triviales expresamente permitidos por `AGENTS.md`.

---

## Aprobaciones humanas

Solicitar aprobación humana cuando la feature incluya decisiones difíciles de revertir, como:

* autenticación;
* autorización;
* billing;
* precios;
* monetización;
* eliminación de datos;
* migraciones destructivas;
* tratamiento de datos sensibles;
* cambios legales;
* integraciones contractuales;
* exposición pública;
* transferencias de ownership;
* moderación;
* mecanismos antifraude;
* operaciones irreversibles;
* cambios importantes de alcance.

El agente puede analizar y proponer, pero no debe asumir autoridad para aprobar estas decisiones.

---

## Prohibiciones

Esta skill no debe:

* escribir código;
* modificar producción;
* crear migraciones;
* seleccionar tecnologías sin necesidad aprobada;
* inventar evidencia;
* ampliar alcance silenciosamente;
* convertir todos los deseos en requisitos;
* diseñar solamente el happy path;
* omitir permisos;
* confundir interfaz oculta con autorización;
* ignorar operaciones o soporte;
* definir analytics invasivo;
* declarar rollback posible sin explicar cómo;
* usar criterios de aceptación vagos;
* crear tareas exclusivamente por capa técnica;
* aprobar automáticamente el diseño propio;
* reemplazar documentación estable por un handoff temporal.

---

## Formato recomendado de `spec.md`

```markdown
# <Feature Name>

## Metadata
## Status
## Source of Scope
## Problem
## Evidence
## Expected Outcome
## Users and Actors
## Scope
## Non-Goals
## Existing Behavior to Preserve
## Preconditions
## Postconditions
## Main Flow
## Alternative Flows
## Exception Flows
## Recovery Flows
## Operational Flows
## Business Rules
## Roles and Permissions
## Ownership
## States
## Transitions
## Validations
## Errors
## Loading States
## Empty States
## Unauthorized States
## Success and Partial Success
## Edge Cases
## Accessibility
## Responsive Behavior
## Metrics
## Analytics Events
## Preliminary Data
## Preliminary Contracts
## Dependencies
## Risks
## Rollout
## Rollback
## Acceptance Criteria
## Candidate Vertical Slices
## Open Questions
## Decisions
## Final Gate
```

---

## Formato recomendado de `test-plan.md`

```markdown
# Test Plan — <Feature Name>

## Scope
## Risks Covered
## Acceptance Criteria Traceability
## Behavior Tests
## Business Rule Tests
## Permission and Ownership Tests
## State Transition Tests
## Validation Tests
## Integration Tests
## End-to-End Tests
## Accessibility Tests
## Responsive Tests
## Resilience Tests
## Security Tests
## Compatibility and Migration Tests
## Analytics and Observability Tests
## Test Data
## Environments
## Evidence Required
## Known Gaps
## Exit Criteria
```

---

## Informe final

Al finalizar, informar:

* feature diseñada;
* gate obtenido;
* resultado esperado;
* alcance principal;
* no objetivos más relevantes;
* cantidad de reglas;
* cantidad de criterios de aceptación;
* riesgos críticos;
* dependencias bloqueantes;
* preguntas abiertas;
* aprobación humana requerida;
* siguiente skill recomendada.

La siguiente skill normalmente será:

* `review-feature`, para revisión independiente;
* `validate-assumptions`, si falta evidencia;
* `define-quality-attributes`, si falta una restricción sistémica;
* `review-architecture`, si existe impacto arquitectónico relevante;
* `create-exec-plan`, si la feature fue aprobada y está lista para planificación.
