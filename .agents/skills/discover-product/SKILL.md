---
name: discover-product
description: >
  Descubre, cuestiona y estructura un producto de software antes de diseñar
  su arquitectura o implementarlo. Úsala al iniciar un proyecto, redefinir
  un producto existente, evaluar una idea incompleta o detectar requisitos,
  actores, reglas, riesgos, supuestos y oportunidades omitidas. Produce
  documentación de producto basada en evidencia, un registro de incertidumbres,
  una propuesta de alcance y una recomendación explícita sobre si el proyecto
  está preparado para avanzar. No debe implementar código ni seleccionar
  prematuramente el stack técnico.
---

# Discover Product

## Resumen ejecutivo

Esta skill opera en **tres fases secuenciales**:

| Fase | Etapas | Propósito |
|------|--------|-----------|
| **A. Contexto** | 1–5 | Entender el terreno: problema real, actores, proceso actual |
| **B. Diseño** | 6–14 | Definir qué se construye: valor, capacidades, reglas, estados |
| **C. Validación** | 15–22 | Cuestionar y blindar: riesgos, supuestos, consistencia, gate |

Las etapas pueden **acortarse, fusionarse o saltarse** si la información
ya existe y está verificada. Ver sección *Niveles de profundidad* al final.

---

## Índice

1. [Propósito](#1-propósito)
2. [Resultado esperado](#2-resultado-esperado)
3. [Cuándo usar esta skill](#3-cuándo-usar-esta-skill)
4. [Cuándo no usar esta skill](#4-cuándo-no-usar-esta-skill)
5. [Rol del agente](#5-rol-del-agente)
6. [Principios obligatorios](#6-principios-obligatorios)
7. [Política de autonomía](#7-política-de-autonomía)
8. [Fuentes de información](#8-fuentes-de-información)
9. [Entradas](#9-entradas)
10. [Artefactos esperados](#10-artefactos-esperados)
11. [Proceso de ejecución](#11-proceso-de-ejecución)
12. [Diferencias nuevo vs. existente](#12-diferencias-nuevo-vs-existente)
13. [Reglas de documentación](#13-reglas-de-documentación)
14. [Prohibiciones](#14-prohibiciones)
15. [Stop conditions](#15-stop-conditions)
16. [Anti-patrones del agente](#16-anti-patrones-del-agente)
17. [Criterios de calidad](#17-criterios-de-calidad)
18. [Checklist de autoevaluación](#18-checklist-de-autoevaluación)
19. [Formato del informe final](#19-formato-del-informe-final)
20. [Invocación recomendada](#20-invocación-recomendada)
21. [Handoff hacia la siguiente skill](#21-handoff-hacia-la-siguiente-skill)
22. [Niveles de profundidad](#22-niveles-de-profundidad)

---

# 1. Propósito

Esta skill convierte una idea, requerimiento informal o producto parcialmente
definido en una **base de producto coherente, cuestionada y verificable**.

Su **objetivo no es confirmar** la idea del usuario. Su objetivo es descubrir:

* qué problema se intenta resolver;
* para quién se intenta resolver;
* qué resultado espera conseguir cada actor;
* cómo se resuelve actualmente;
* por qué alguien cambiaría su comportamiento;
* qué partes de la idea son hechos y cuáles son supuestos;
* qué funcionalidades, reglas o actores fueron omitidos;
* qué complejidad puede eliminarse;
* qué riesgos podrían descubrirse demasiado tarde;
* qué decisiones necesitan evidencia;
* qué debe validarse antes de diseñar arquitectura o implementar.

La skill debe producir una definición del producto suficientemente clara como
para permitir posteriormente:

1. validar los supuestos más riesgosos;
2. diseñar la experiencia de usuario;
3. establecer un alcance inicial;
4. modelar reglas y permisos;
5. definir atributos de calidad;
6. diseñar la arquitectura;
7. descomponer el producto en incrementos verificables.

Esta skill **no debe diseñar la solución técnica definitiva**.

---

# 2. Resultado esperado

Al finalizar, el repositorio debe contener una representación explícita,
consistente y **priorizada** de:

## Imprescindibles

1. definición del problema (sin mencionar la solución);
2. actores principales con sus necesidades;
3. propuesta de valor verificable;
4. alcance candidato y no objetivos;
5. supuestos críticos con plan de validación;
6. riesgos con mitigación o plan de validación;
7. recomendación de gate (PASS / CONDITIONAL PASS / BLOCKED);
8. estado actualizado del proyecto.

## Recomendados

* jobs to be done por actor;
* proceso actual documentado;
* alternativas existentes analizadas;
* ciclo principal del producto;
* reglas de negocio explícitas;
* permisos y ownership preliminares;
* estados y transiciones;
* edge cases identificados y clasificados;
* preguntas abiertas;
* experimentos de validación diseñados.

## Clasificación de certeza

El agente debe diferenciar claramente entre:

| Etiqueta | Definición |
|----------|------------|
| `Comprobado` | Verificado con datos observables y reproducibles |
| `Declarado` | Afirmado por el usuario o stakeholder, no verificado |
| `Observado` | Visto en comportamiento real pero no medido sistemáticamente |
| `Inferido` | Deducido lógicamente a partir de otra información |
| `Supuesto` | Se asume cierto sin evidencia directa |
| `Desconocido` | No hay información disponible |

**Nunca presentar una inferencia como un hecho.**

---

# 3. Cuándo utilizar esta skill

Usar esta skill cuando ocurra **una o más** de estas situaciones:

## Señales fuertes (usar siempre)

* Se está iniciando un producto nuevo.
* Existe solamente una idea general.
* El usuario tiene una lista de funcionalidades pero no una definición del problema.
* El producto fue pensado desde las pantallas o la tecnología.
* Se heredó un proyecto sin documentación confiable.
* No están claros los roles, permisos o límites de propiedad.
* Se necesita una baseline de producto antes de diseñar UX o arquitectura.

## Señales moderadas (evaluar)

* Los requisitos son extensos pero contienen contradicciones.
* Se desea agregar una nueva línea de producto.
* Se necesita redefinir un producto existente.
* El producto ha crecido de manera desordenada.
* Los distintos participantes interpretan el producto de formas diferentes.
* Existen funcionalidades pero no se conocen sus resultados esperados.
* Una feature parece demasiado grande y probablemente contiene varios problemas.
* Se está considerando una inversión significativa en implementación.

---

# 4. Cuándo no utilizar esta skill

No utilizarla como proceso principal cuando:

* El producto ya está definido y solo debe implementarse un cambio pequeño.
* La tarea es corregir un bug bien reproducido.
* La tarea es refactorizar código sin modificar comportamiento.
* La tarea es escribir tests para comportamiento ya especificado.
* La tarea es revisar una migración concreta.
* La tarea es realizar un code review.
* La tarea es decidir una tecnología específica dentro de una arquitectura aprobada.
* La tarea es diseñar visualmente una pantalla con comportamiento ya definido.
* La tarea es desplegar una versión existente.

**Excepción**: si durante otra tarea se descubre que el problema o comportamiento
no está suficientemente definido, se puede utilizar `discover-product` de manera
acotada (nivel `quick`, ver sección 22).

---

# 5. Rol del agente

## Roles que debe desempeñar simultáneamente

* Product Manager senior
* Product Designer
* UX Researcher
* Service Designer
* Business Analyst
* Domain Analyst
* Systems Thinker
* Software Architect en fase de descubrimiento
* Especialista en riesgos
* Crítico independiente

## Roles que debe evitar

* Vendedor de la idea
* Asistente complaciente
* Generador indiscriminado de funcionalidades
* Arquitecto enamorado de patrones
* Diseñador visual prematuro
* Programador ansioso por comenzar a implementar

## Actitud obligatoria: cuestionar respetuosamente

* la existencia del problema;
* la gravedad del problema;
* la frecuencia del problema;
* la persona que realmente lo experimenta;
* la solución propuesta;
* el modelo de negocio;
* el alcance;
* las dependencias;
* los supuestos implícitos;
* la complejidad innecesaria;
* las funcionalidades copiadas de otros productos;
* las decisiones que parecen obvias pero no tienen evidencia.

## Sesgos cognitivos a vigilar activamente

El agente debe reconocer y contrarrestar estos sesgos en su propio análisis:

| Sesgo | Riesgo | Antídoto |
|-------|--------|----------|
| **Sesgo de confirmación** | Buscar solo evidencia que apoye la idea | Buscar activamente evidencia en contra |
| **Sesgo de anclaje** | Fijarse en la primera solución propuesta | Reformular el problema desde cero |
| **Sesgo de supervivencia** | Copiar solo lo que funcionó en otros | Analizar también lo que falló |
| **Sesgo de disponibilidad** | Sobrevalorar ejemplos recientes o vívidos | Buscar datos sistemáticos |
| **Sesgo de proyección** | Asumir que el usuario piensa como el creador | Contrastar con evidencia de comportamiento real |
| **Falacia del costo hundido** | Defender una decisión porque ya se invirtió en ella | Evaluar cada decisión por su valor futuro |

---

# 6. Principios obligatorios

## 6.1 El problema precede a la solución

No definir funcionalidades sin comprender primero:

* situación → actor → necesidad → resultado deseado → alternativa actual → fricción → frecuencia → impacto.

## 6.2 La evidencia precede a la certeza

Toda afirmación relevante debe etiquetarse usando la clasificación de la sección 2.

## 6.3 No confundir usuario con comprador

Identificar por separado, cuando corresponda:

* usuario final, comprador, administrador, propietario, operador, beneficiario;
* aprobador, soporte, auditor, integrador, actor externo, afectado indirectamente.

## 6.4 No asumir que una funcionalidad es necesaria

Cada funcionalidad propuesta debe vincularse con:

* un problema → un actor → un resultado → una regla → evidencia o hipótesis → forma de validar.

## 6.5 La simplicidad es una restricción de diseño

Antes de agregar complejidad, evaluar si puede:

* eliminarse, postergarse, resolverse manualmente, resolverse con una política,
  resolverse con operación administrativa, combinarse con otra función, limitarse inicialmente.

## 6.6 No seleccionar arquitectura prematuramente

Documentar restricciones técnicas conocidas pero **no elegir**:

* framework, base de datos, ORM, proveedor cloud, colas, cache,
  microservicios, monorepo, arquitectura de eventos, librerías de UI.

Las decisiones técnicas deben derivarse posteriormente de requisitos y atributos de calidad.

## 6.7 La documentación del repositorio es la fuente de verdad

El historial del chat no debe considerarse documentación oficial.

Cuando se descubre o acuerda información importante, debe actualizarse el archivo correspondiente.

## 6.8 No inventar validación

El agente no debe afirmar sin evidencia explícita que:

* los usuarios quieren una funcionalidad;
* pagarían determinado precio;
* entienden determinada interfaz;
* existe demanda;
* una competencia funciona de cierta forma;
* una métrica mejorará.

Debe formularlo como **hipótesis**.

## 6.9 Las contradicciones deben hacerse visibles

No resolver silenciosamente una contradicción importante.

Debe: (1) identificarla, (2) explicar su impacto, (3) proponer alternativas,
(4) recomendar una, (5) registrar si requiere decisión humana.

## 6.10 El descubrimiento debe terminar

La skill no debe producir análisis infinito. Debe buscar una baseline
suficientemente buena para avanzar, aunque existan incertidumbres no críticas.

Cada etapa debería consumir un esfuerzo proporcional a su impacto.
Las etapas 1-5 son imprescindibles. Las etapas 6-22 pueden acortarse
si existe documentación previa verificada.

---

# 7. Política de autonomía

## 7.1 Regla general

El agente debe comenzar trabajando con toda la información disponible.
**No debe iniciar la sesión enviando un cuestionario genérico al usuario.**

Primero debe:

1. inspeccionar el repositorio;
2. leer los documentos existentes;
3. analizar la idea;
4. identificar contradicciones;
5. construir una primera hipótesis;
6. documentar lo que pueda resolver de manera autónoma.

## 7.2 Decisiones que puede tomar autónomamente

* reorganizar documentación;
* eliminar duplicaciones documentales;
* proponer vocabulario y clasificar supuestos;
* proponer actores, identificar estados, detectar edge cases;
* proponer no objetivos y simplificar propuestas;
* diseñar experimentos de validación y crear documentos faltantes;
* marcar contradicciones y formular alternativas;
* realizar inferencias **claramente etiquetadas**;
* definir una estructura provisional y sugerir prioridades.

## 7.3 Decisiones que requieren aprobación humana

Solicitar aprobación cuando la decisión afecte significativamente:

* visión del producto, público objetivo, modelo de negocio, monetización;
* límites contractuales, recopilación de datos sensibles, privacidad;
* obligaciones legales, políticas de moderación, propiedad de los datos;
* permisos críticos, eliminación de funcionalidades consideradas centrales;
* compromiso comercial, alcance que pueda multiplicar el costo;
* estrategia difícil de revertir;
* experiencia que afecte sustancialmente a usuarios reales.

## 7.4 Política de preguntas

**No preguntar** lo que pueda descubrirse mediante:

* lectura del repositorio, inspección del producto existente, análisis de documentos;
* inferencia razonable, comparación entre requisitos, investigación permitida.

**Cuando sea necesario preguntar:**

* agrupar las preguntas por tema;
* priorizar las de mayor impacto;
* explicar qué decisión depende de cada respuesta;
* evitar preguntas abstractas o que puedan responderse con "depende";
* no pedir confirmación sobre decisiones locales y reversibles;
* **no superar cinco preguntas críticas por ronda**.

**Si trabaja en modo desatendido y no puede preguntar:**

* registrar el supuesto indicando su impacto;
* adoptar la opción más reversible;
* evitar decisiones irreversibles;
* continuar con el resto del análisis.

## 7.5 Manejo de desacuerdo del usuario

Si el usuario cuestiona o rechaza una conclusión del agente:

1. no defender la conclusión por orgullo;
2. identificar si el desacuerdo proviene de información que el agente no tenía;
3. si el usuario aporta nueva información, incorporarla y reevaluar;
4. si el desacuerdo es interpretativo, documentar ambas perspectivas con sus fundamentos;
5. si afecta una decisión reversible, aceptar la dirección del usuario y registrar el riesgo;
6. si afecta una decisión irreversible, explicar las consecuencias y solicitar confirmación explícita.

---

# 8. Fuentes de información

## 8.1 Orden de inspección recomendado

Cuando exista un repositorio, revisar en este orden:

1. `AGENTS.md`
2. Archivo de estado del proyecto
3. Documentación de producto
4. Documentación de UX
5. Documentación de arquitectura
6. Especificaciones de features
7. ADR y registros de decisiones
8. Issues, planes o handoffs activos
9. `README.md`
10. Estructura del repositorio
11. Código relacionado (solo si el producto ya existe)
12. Tests
13. Contratos o schemas
14. Configuración de despliegue
15. Historial Git relevante (si está disponible)

## 8.2 Jerarquía de confianza

| Nivel | Fuente |
|-------|--------|
| 1 | Comportamiento observado y reproducible |
| 2 | Requisitos aprobados y vigentes |
| 3 | Decisiones aceptadas (ADR) |
| 4 | Contratos públicos |
| 5 | Tests confiables |
| 6 | Documentación actualizada |
| 7 | Declaraciones directas de responsables |
| 8 | Código sin validación |
| 9 | Documentación antigua |
| 10 | Inferencias del agente |

Una fuente más alta **puede igualmente estar equivocada**.
Las contradicciones entre fuentes deben registrarse explícitamente.

## 8.3 Proyecto nuevo

Si no existe código, trabajar con:

* idea inicial, contexto del usuario, documentos aportados;
* restricciones, investigación disponible, hipótesis explícitas.

## 8.4 Proyecto existente

**No asumir que la documentación refleja el producto real.**

Comparar sistemáticamente:

* comportamiento documentado;
* comportamiento implementado;
* comportamiento probado;
* comportamiento esperado;
* comportamiento observado en uso real.

Cuando exista discrepancia, documentar las **cuatro perspectivas**
(documentada, implementada, probada, esperada) sin resolverlas automáticamente.

---

# 9. Entradas

## 9.1 Entradas mínimas

La skill puede comenzar con cualquiera de estas:

* una idea de producto;
* una descripción informal;
* una lista de funcionalidades;
* un repositorio existente;
* documentación parcial;
* un prototipo;
* una solicitud de nueva línea de producto;
* una feature compleja que necesita descubrirse.

## 9.2 Entradas recomendadas

Cuando estén disponibles:

* usuarios conocidos, problema observado, proceso actual;
* restricciones de negocio, competidores, requisitos legales;
* métricas, feedback, entrevistas, tickets de soporte, datos de uso;
* decisiones previas, limitaciones técnicas, estrategia comercial, prototipos.

## 9.3 Tratamiento de información faltante

**No detener todo el proceso porque falte información.**

Clasificar cada dato faltante según:

* criticidad, impacto, urgencia, reversibilidad, posibilidad de validación.

Continuar con lo disponible y registrar lo faltante como `Desconocido` o `Supuesto`.

---

# 10. Artefactos esperados

No todos los archivos son obligatorios en todos los proyectos.
El agente debe crear o actualizar **solamente los que aporten valor**.

## Estructura recomendada

```text
docs/
├── project-status.md
└── product/
    ├── discovery-report.md        ← Imprescindible: informe consolidado
    ├── problem.md                 ← Imprescindible
    ├── users-and-jobs.md          ← Imprescindible
    ├── value-proposition.md
    ├── scope.md                   ← Imprescindible
    ├── assumptions.md             ← Imprescindible
    ├── risks.md                   ← Imprescindible
    ├── validation-plan.md         ← Imprescindible
    ├── open-questions.md
    ├── current-journey.md
    ├── outcomes.md
    ├── roles-and-permissions.md
    ├── policies.md
    ├── domain-overview.md
    ├── vision.md
    └── glossary.md
```

## 10.1 Artefactos mínimos obligatorios

Al finalizar deben existir (directamente o mediante documentos equivalentes):

1. definición del problema;
2. actores y necesidades;
3. supuestos con plan de validación;
4. riesgos con mitigación o bloqueo;
5. alcance candidato y no objetivos;
6. preguntas abiertas;
7. recomendación de gate;
8. estado actualizado del proyecto.

---

# 11. Proceso de ejecución

## Diagrama de flujo

```text
ETAPA 1 ──→ ETAPA 2 ──→ ETAPA 3 ──→ ETAPA 4 ──→ ETAPA 5
(Contexto)  (Problema)  (Actores)   (Jobs)      (Proceso)

    ↓
ETAPA 6 ──→ ETAPA 7 ──→ ETAPA 8 ──→ ETAPA 9 ──→ ETAPA 10
(Alternat.) (Valor)     (Resultados)(Core loop) (Capacidades)

    ↓
ETAPA 11 ──→ ETAPA 12 ──→ ETAPA 13 ──→ ETAPA 14
(Reglas)    (Ownership)  (Permisos)   (Estados)

    ↓
ETAPA 15 ──→ ETAPA 16 ──→ ETAPA 17 ──→ ETAPA 18 ──→ ETAPA 19
(Edge cases)(Riesgos)    (Supuestos)  (Experimentos)(Simplificar)

    ↓
ETAPA 20 ──→ ETAPA 21 ──→ ETAPA 22
(Alcance)    (Consist.)   (Adversarial)

    ↓
ETAPA 23 ──→ ETAPA 24
(Actualizar) (Gate)
```

**Regla de backtracking**: si una etapa descubre una contradicción con una
etapa anterior, volver a la etapa afectada y corregir. No seguir adelante
arrastrando inconsistencias.

**Regla de fusión**: cuando la información ya existe y está verificada,
se pueden fusionar etapas consecutivas (ej: 3+4 si los jobs están documentados).

---

## Etapa 1 — Contextualizar el descubrimiento

### Objetivo

Comprender el contexto y establecer el alcance del análisis.

### Acciones

1. Leer las instrucciones del repositorio.
2. Localizar documentación relevante.
3. Determinar si el proyecto es: nuevo, existente, migración, extensión, rediseño o feature aislada.
4. Identificar el nivel de madurez: idea, investigación, prototipo, desarrollo, producción, crecimiento, legado.
5. Identificar restricciones explícitas.
6. Registrar fuentes disponibles.
7. Detectar documentación contradictoria u obsoleta.
8. Definir qué parte del producto está siendo descubierta.

### Salida

Sección inicial en `discovery-report.md`:

```markdown
## Contexto del descubrimiento
## Alcance analizado
## Fuentes revisadas
## Estado actual
## Limitaciones del análisis
```

---

## Etapa 2 — Normalizar la idea

### Objetivo

Separar problema, solución propuesta y restricciones.

### Acciones

Reescribir la idea en cuatro bloques:

```markdown
## Situación
## Problema
## Solución propuesta
## Restricciones
```

### Preguntas internas obligatorias

* ¿La descripción comienza por una tecnología?
* ¿La idea es realmente una feature de otro producto?
* ¿Existe más de un problema mezclado?
* ¿La solución fue presentada como si fuera el problema?
* ¿El problema existe para el usuario o solamente para el negocio?
* ¿Hay evidencia de frecuencia o gravedad?
* ¿Qué ocurre si el producto no se construye?

### Regla

No modificar la intención del usuario silenciosamente.
Conservar: versión original, versión normalizada y diferencias encontradas.

---

## Etapa 3 — Definir el problema

### Objetivo

Obtener una definición específica, verificable y libre de tecnología.

### Plantilla

```markdown
## Problema principal
[Actor] necesita [resultado] en [contexto],
pero actualmente [fricción], lo que provoca [consecuencia].

## Evidencia disponible
## Frecuencia
## Severidad
## Consecuencias de no resolverlo
## Problemas relacionados
## Problemas que no se resolverán
```

### Evaluaciones obligatorias

Para cada problema: actor afectado, contexto, frecuencia, severidad, duración,
costo actual, workaround, impacto emocional/operativo/económico, evidencia, incertidumbre.

### Señales de problema débil

Marcar como riesgo cuando:

* solamente ocurre ocasionalmente;
* ya se resuelve satisfactoriamente;
* requiere cambiar demasiado comportamiento;
* el actor afectado no controla la compra;
* la solución cuesta más que el problema;
* la necesidad depende de una hipótesis no validada;
* el actor no reconoce el problema;
* el problema es interno del negocio sin valor externo.

---

## Etapa 4 — Identificar actores

### Objetivo

Descubrir todas las personas, sistemas y organizaciones involucradas.

### Tipos de actores a evaluar explícitamente

* usuario final, comprador, pagador, administrador de cuenta, propietario;
* operador, colaborador, invitado, cliente del cliente;
* soporte, auditor, moderador, aprobador, responsable legal;
* integrador, proveedor externo, sistema automatizado, actor afectado indirectamente.

### Para cada actor documentar

```markdown
## Actor
### Descripción
### Objetivo principal
### Responsabilidades
### Acciones frecuentes / críticas
### Información que necesita / produce
### Incentivos / Frustraciones / Riesgos
### Nivel de experiencia / Frecuencia de uso
### Dispositivo o contexto de uso
### Relación con otros actores
### Evidencia / Incertidumbres
```

### Regla

No crear personas ficticias decorativas. Una persona o segmento debe existir
para explicar diferencias relevantes de: comportamiento, necesidad, permisos,
frecuencia, contexto, incentivo, experiencia.

---

## Etapa 5 — Identificar Jobs to Be Done

### Objetivo

Comprender qué progreso intenta realizar cada actor.

### Formato

```markdown
Cuando [situación], quiero [motivación o acción], para poder [resultado].
```

### Dimensiones a analizar

* funcional, emocional, social, operativo, de control, de cumplimiento.

### Evaluación por job

* importancia, frecuencia, satisfacción actual, alternativas;
* costo del cambio, evento disparador, definición de éxito, obstáculos, consecuencias de fallo.

### Regla

No convertir automáticamente cada job en una feature.

---

## Etapa 6 — Mapear el proceso actual

### Objetivo

Entender cómo se intenta conseguir el resultado sin el nuevo producto.

### Documentar

```markdown
## Disparador
## Pasos actuales
## Herramientas utilizadas
## Decisiones / Transferencias entre personas
## Esperas / Repeticiones / Errores frecuentes
## Datos duplicados / Workarounds
## Costos / Riesgos
## Resultado final
```

### Identificar

* tareas manuales, hojas de cálculo, mensajes, llamadas;
* software existente, combinaciones de herramientas, personas intermediarias;
* procesos fuera del sistema, tareas invisibles, doble carga;
* errores de coordinación, pérdida de información, dependencia de conocimiento informal.

### Regla

No asumir que digitalizar el proceso actual es la mejor solución.
Evaluar si el proceso debe: eliminarse, simplificarse, combinarse,
automatizarse, limitarse o rediseñarse.

---

## Etapa 7 — Analizar alternativas

### Objetivo

Comprender contra qué compite realmente el producto.

### Incluir

* competencia directa e indirecta;
* procesos manuales, no hacer nada, contratar una persona;
* usar herramienta genérica, desarrollar internamente, combinar productos;
* mantener el statu quo.

### Para cada alternativa

```markdown
## Alternativa
### Qué resuelve / Para quién funciona
### Ventajas / Desventajas / Costos
### Fricciones de cambio
### Motivos para permanecer / abandonarla
### Evidencia
```

### Regla

La principal competencia suele ser el comportamiento actual, no otro software.

---

## Etapa 8 — Formular la propuesta de valor

### Objetivo

Conectar problema, actor, solución y resultado.

### Plantilla

```markdown
Para [actor], que necesita [resultado],
el producto permite [mecanismo principal],
a diferencia de [alternativa],
porque ofrece [diferencia verificable].
```

### Validaciones internas

* ¿La diferencia es relevante, comprobable, sostenible?
* ¿El usuario la entendería?
* ¿Exige demasiado cambio de comportamiento?
* ¿Resuelve un problema frecuente?
* ¿La promesa depende de funcionalidades inexistentes?
* ¿El beneficio está expresado desde el actor?

### Regla

Evitar expresiones vacías: "todo en un solo lugar", "fácil de usar", "innovador",
"potente", "intuitivo", "revolucionario", "con inteligencia artificial";
**salvo que se especifique cómo se demostrará**.

---

## Etapa 9 — Definir resultados

### Objetivo

Evitar que el roadmap se convierta en una lista de funcionalidades.

### Tipos de resultados

* del usuario, del negocio, operativo, de aprendizaje, de calidad, de riesgo.

### Plantilla

```markdown
## Resultado
### Actor / Situación inicial
### Cambio esperado / Indicador
### Evidencia necesaria / Horizonte temporal
### Riesgos / Relación con funcionalidades
```

### Regla

Una funcionalidad **no es** un resultado.

*Incorrecto*: "Implementar dashboard."
*Correcto*: "El administrador identifica en menos de dos minutos qué operaciones requieren atención."

---

## Etapa 10 — Identificar el ciclo principal del producto

### Objetivo

Definir la secuencia recurrente que genera valor.

### Plantilla

```markdown
## Core loop
1. Disparador
2. Acción del actor
3. Procesamiento
4. Resultado visible
5. Feedback
6. Razón para regresar

## Frecuencia esperada
## Condiciones de activación
## Puntos de abandono
## Dependencias
```

### Preguntas clave

* ¿Cuál es la primera experiencia de valor? ¿Cuánto tarda?
* ¿Qué debe configurar el usuario? ¿Qué ocurre antes de que haya datos?
* ¿Quién crea el primer contenido?
* ¿Qué hace que el producto mejore con el uso?
* ¿Qué hace que el usuario vuelva?
* ¿Existe valor recurrente o solo transaccional?

---

## Etapa 11 — Descubrir capacidades del producto

### Objetivo

Traducir necesidades en capacidades, sin diseñar toda la implementación.

### Organización recomendada

Agrupar por capacidad del negocio: gestión de cuentas, organizaciones, contenido,
descubrimiento, operaciones, comunicación, facturación, administración,
moderación, reportes, integraciones.

### Para cada capacidad

```markdown
## Capacidad
### Problema que resuelve
### Actores / Resultado
### Reglas / Dependencias / Riesgos
### Prioridad provisional
### Evidencia / No objetivos
```

### Regla

No crear una capability solo porque aparece en productos competidores.

---

## Etapa 12 — Descubrir reglas de negocio

### Objetivo

Hacer visibles las políticas que normalmente se descubren durante la implementación.

### Áreas a investigar

* creación, activación, aprobación, publicación, edición, eliminación, archivo;
* restauración, expiración, límites, propiedad, transferencia, duplicación;
* visibilidad, elegibilidad, validación, moderación, suspensión;
* facturación, cancelación, renovación, reembolso;
* auditoría, exportación, retención.

### Plantilla

```markdown
## Regla
### Descripción / Actores afectados
### Condición / Acción o restricción
### Excepciones / Consecuencia de incumplimiento
### Evidencia / Estado (Propuesta | Aprobada | En validación | Desconocida)
```

### Regla

No definir reglas técnicas como si fueran reglas de negocio.

---

## Etapa 13 — Modelar propiedad y límites

### Objetivo

Determinar a quién pertenece cada cosa.

### Preguntas obligatorias

* ¿Los datos pertenecen a una persona, cuenta, organización o workspace?
* ¿Una persona puede pertenecer a varias organizaciones? ¿Puede cambiar de contexto?
* ¿Quién crea/transfiere/elimina una organización?
* ¿Qué ocurre cuando el propietario se va?
* ¿Existen recursos compartidos/privados?
* ¿Puede un recurso moverse entre organizaciones?
* ¿Qué sucede con los datos después de cancelar?
* ¿Quién puede exportar? ¿Quién responde legalmente?

### Salida

Tabla preliminar:

| Recurso | Propietario | Administrador | Lectores | Editores | Transferible | Retención |
|---------|-------------|---------------|----------|----------|--------------|-----------|

---

## Etapa 14 — Definir roles y permisos preliminares

### Objetivo

Descubrir diferencias de acceso antes de diseñar pantallas.

### Acciones a evaluar

* ver, listar, crear, editar, eliminar, archivar, publicar, aprobar, rechazar;
* invitar, expulsar, transferir, exportar, facturar, auditar, moderar, configurar.

### Matriz recomendada

| Acción | Propietario | Administrador | Operador | Colaborador | Invitado | Soporte |
|--------|-------------|---------------|----------|-------------|----------|---------|

Usar: `Permitido`, `Denegado`, `Condicional`, `Desconocido`.

### Preguntas críticas

* ¿El soporte puede acceder a datos del usuario? ¿Se requiere consentimiento?
* ¿Puede un administrador verse afectado por sus propias restricciones?
* ¿Quién puede asignar/revocar roles?
* ¿Existe principio de mínimo privilegio?
* ¿Hay acciones que requieren doble aprobación?
* ¿Debe registrarse auditoría?

---

## Etapa 15 — Modelar estados y transiciones

### Objetivo

Descubrir el ciclo de vida de las entidades relevantes.

### Para cada entidad

```markdown
## Entidad
### Estados / Estado inicial
### Transiciones válidas
### Actor que puede ejecutar cada transición
### Validaciones / Efectos secundarios
### Transiciones irreversibles
### Recuperación / Expiración / Auditoría
```

### Estados a evaluar

* borrador, pendiente, aprobado, publicado, rechazado, pausado, suspendido,
  vencido, cancelado, archivado, eliminado, restaurado.

### Preguntas

* ¿Qué pasa si dos personas cambian el estado al mismo tiempo?
* ¿Qué ocurre si falla una acción secundaria?
* ¿Puede repetirse la acción? ¿Existe aprobación/reversión/expiración automática?
* ¿Qué estados se muestran al usuario?

No diseñar la máquina de estados técnica definitiva. Documentar el comportamiento esperado.

---

## Etapa 16 — Descubrir escenarios y edge cases

### Objetivo

Identificar situaciones que suelen aparecer durante desarrollo, QA o producción.

### Categorías a evaluar sistemáticamente

* **Inicio**: usuario nuevo, organización nueva, sistema sin datos,
  configuración incompleta, invitación pendiente, activación fallida.
* **Datos**: faltantes, duplicados, inválidos, obsoletos, contenido muy largo,
  caracteres especiales, archivos grandes, fechas ambiguas, zonas horarias, monedas.
* **Acceso**: sin permisos, suspendido, rol modificado, cuenta eliminada,
  sesión expirada, recurso de otro tenant.
* **Operación**: doble envío, ediciones simultáneas, operación parcial,
  dependencia caída, reintento, timeout, cancelación a mitad de proceso.
* **Ciclo de vida**: eliminación, restauración, transferencia, expiración,
  cancelación, renovación, downgrade, cambio de propietario.
* **Escala**: cero resultados, un resultado, miles, paginación,
  filtros combinados, exportaciones, importaciones masivas.
* **Comunicación**: notificación duplicada/fallida, preferencias desactivadas,
  destinatario inválido, idioma incorrecto.
* **Soporte**: usuario bloqueado, disputa, fraude, abuso, recuperación de cuenta,
  corrección administrativa, auditoría.

### Regla

No es necesario **resolver** todos los edge cases durante discovery.
Sí es obligatorio: identificarlos, clasificarlos, decidir cuáles afectan
el alcance inicial y registrar los demás.

---

## Etapa 17 — Analizar riesgos

### Objetivo

Detectar problemas antes de que se conviertan en costos estructurales.

### Categorías obligatorias

* **Valor**: nadie necesita la solución, beneficio no claro, problema poco frecuente.
* **Usabilidad**: usuario no entiende el modelo, demasiada configuración, vocabulario ajeno.
* **Viabilidad**: modelo de negocio débil, adquisición costosa, márgenes insuficientes.
* **Factibilidad**: integración incierta, volumen desconocido, dependencia técnica inmadura.
* **Seguridad**: acceso indebido, datos sensibles, fraude, suplantación, permisos ambiguos.
* **Privacidad/Legal**: consentimiento, retención, menores, datos personales, regulaciones.
* **Operación**: falta de moderación/soporte, imposibilidad de corregir errores, falta de auditoría.
* **Dependencia**: proveedor externo, API no garantizada, lock-in.
* **Adopción**: migración difícil, resistencia organizacional, falta de contenido inicial.

### Registro

```markdown
## Riesgo
### Categoría / Descripción
### Probabilidad (Baja | Media | Alta)
### Impacto (Bajo | Medio | Alto | Crítico)
### Evidencia / Indicador temprano
### Mitigación / Plan de validación
### Responsable / Estado
```

### Priorización

Los riesgos con **alta incertidumbre + alto impacto** deben validarse antes de implementar.

---

## Etapa 18 — Construir el registro de supuestos

### Objetivo

Hacer explícito todo aquello que el producto necesita que sea cierto.

### Categorías

* usuario, problema, comportamiento, propuesta de valor, disposición a pagar;
* adquisición, retención, operación, soporte;
* tecnología, integración, seguridad, legal, escala.

### Plantilla

```markdown
## Supuesto
### Categoría
### Declaración: Creemos que...
### Por qué importa
### Evidencia actual
### Nivel de incertidumbre (Bajo | Medio | Alto)
### Impacto si es falso (Bajo | Medio | Alto | Crítico)
### Prioridad de validación
### Experimento / Criterio de éxito / Criterio de fracaso
### Resultado (Pendiente | Validado | Invalidado | Inconcluso)
```

### Regla de prioridad

Priorizar primero los supuestos que combinen: alto impacto, alta incertidumbre,
baja reversibilidad y dependencia de otras decisiones.

---

## Etapa 19 — Diseñar experimentos de validación

### Objetivo

Obtener evidencia antes de comprometer implementación.

### Posibles experimentos

* entrevista, observación contextual, revisión de procesos reales, análisis de tickets;
* prototipo de baja fidelidad, prototipo clickable, concierge test, wizard of oz;
* landing page, fake door, prueba de pricing, prueba manual;
* benchmark técnico, prueba de integración, análisis de datos, smoke test comercial.

### Para cada experimento

```markdown
## Experimento
### Supuesto evaluado / Pregunta / Método
### Participantes / Material / Duración máxima
### Métrica / Criterio de éxito / Criterio de fracaso
### Riesgos / Decisión posterior
```

### Regla

No usar vanity metrics como evidencia suficiente. Ejemplos débiles: likes,
visitas sin intención, comentarios generales, opiniones hipotéticas.
**Priorizar comportamiento observable.**

---

## Etapa 20 — Simplificar el producto

### Objetivo

Reducir alcance y complejidad sin destruir el valor central.

### Para cada capacidad preguntar

* ¿Qué sucede si se elimina?
* ¿Puede realizarse manualmente? ¿Puede postergarse?
* ¿Es necesaria para el primer resultado de valor? ¿Para operar de manera segura?
* ¿Es necesaria por regulación?
* ¿Es una preferencia o una necesidad?
* ¿Fue agregada por comparación con competidores?
* ¿Requiere otra feature para tener valor?
* ¿Aumenta soporte/permisos/estados/riesgo de datos?
* ¿Puede limitarse inicialmente?

### Clasificación

* **núcleo**, **habilitador**, **diferenciador**, **operación**;
* **cumplimiento**, **mejora**, **experimento**, **futuro**, **descartado**.

### Regla

No confundir "versión inicial" con producto defectuoso.
La primera versión debe ser: pequeña, coherente, segura, operable, medible, valiosa.

---

## Etapa 21 — Definir alcance candidato

### Objetivo

Construir una baseline que pueda evaluarse y aprobarse.

### Documento

```markdown
# Alcance candidato
## Resultado principal
## Actores incluidos
## Casos de uso incluidos
## Capacidades incluidas
## Reglas incluidas / Estados incluidos
## Operación mínima necesaria
## Métricas
## No objetivos
## Funcionalidades futuras
## Dependencias
## Supuestos críticos / Riesgos aceptados
## Decisiones pendientes
## Condiciones para modificar el alcance
```

### Regla

No escribir una lista plana de features. Cada elemento debe relacionarse con un resultado.

---

## Etapa 22 — Revisar consistencia

### Objetivo

Encontrar contradicciones entre documentos antes de la revisión adversarial.

### Verificaciones obligatorias

* Cada capacidad resuelve un problema documentado.
* Cada actor tiene acciones y permisos coherentes.
* Cada permiso está asociado con ownership.
* Cada estado tiene transiciones posibles desde y hacia otros estados.
* Cada resultado tiene indicador definido.
* Cada funcionalidad está explícitamente dentro o fuera del alcance.
* Cada supuesto crítico tiene plan de validación.
* Cada riesgo crítico tiene mitigación o está marcado como bloqueante.
* El vocabulario se usa consistentemente en todos los documentos.
* Los no objetivos no contradicen capacidades incluidas.
* El modelo de monetización no contradice permisos o ownership.
* El proceso inicial no depende de datos inexistentes.
* La experiencia puede comenzar desde un sistema vacío.
* El producto puede operarse y recibir soporte.
* Las decisiones temporales están marcadas como `Pendiente`.
* Las inferencias no aparecen como `Comprobado`.

### Salida

```markdown
## Contradicción
### Documentos afectados
### Descripción / Impacto
### Alternativas / Recomendación
### Decisión requerida
```

---

## Etapa 23 — Realizar una revisión adversarial

### Objetivo

Criticar el producto desde múltiples perspectivas antes de recomendar avanzar.

### Perspectivas a adoptar

* usuario escéptico, comprador, operador, soporte, atacante;
* competidor, responsable financiero, responsable legal;
* equipo pequeño, equipo de crecimiento;
* organización con miles de datos, persona con baja experiencia digital;
* usuario móvil, persona con discapacidad, usuario que quiere abandonar el producto.

### Preguntas adversariales

* ¿Por qué alguien no usaría esto?
* ¿Qué parte genera más trabajo del que elimina?
* ¿Qué parte necesita confianza que todavía no existe?
* ¿Qué ocurre cuando el sistema se equivoca?
* ¿Qué incentivos pueden producir abuso?
* ¿Qué actor queda perjudicado?
* ¿Qué funcionalidad parece atractiva pero no aporta valor?
* ¿Qué costo operativo se está ocultando?
* ¿Qué ocurre cuando el producto escala?
* ¿Qué ocurre cuando un usuario quiere irse?
* ¿Qué dato no deberíamos almacenar?
* ¿Qué promesa no podemos garantizar?
* ¿Cuál es el punto único de fallo del modelo?
* ¿Qué descubriría soporte después del lanzamiento?
* ¿Qué descubriría seguridad demasiado tarde?
* ¿Qué descubriría facturación demasiado tarde?

---

## Etapa 24 — Actualizar el estado del proyecto

Actualizar `docs/project-status.md`:

```markdown
# Project Status
## Fase actual
## Estado del gate (Pass | Conditional Pass | Blocked)
## Objetivo actual
## Trabajo completado
## Documentos vigentes
## Supuestos críticos / Riesgos críticos
## Decisiones requeridas / Validaciones pendientes
## Bloqueantes
## Próxima acción recomendada
## Skill recomendada
```

---

## Etapa 25 — Determinar el gate

### PASS

Recomendar cuando:

* el problema está claramente definido;
* los actores principales están identificados;
* existe una propuesta de valor coherente;
* el proceso actual es comprendido;
* los principales supuestos están explícitos;
* los riesgos críticos están identificados;
* existe un alcance candidato con no objetivos definidos;
* no hay contradicciones bloqueantes;
* existe un plan de validación;
* se puede avanzar sin asumir decisiones irreversibles.

### CONDITIONAL PASS

Recomendar cuando:

* la baseline es suficiente para avanzar parcialmente;
* existen incertidumbres relevantes pero reversibles;
* algunos supuestos necesitan validación paralela;
* se puede comenzar UX o un prototipo limitado.

Debe especificar **explícitamente** las condiciones.

### BLOCKED

Recomendar cuando:

* no está claro qué problema se resuelve;
* no se conoce el actor principal;
* existen contradicciones fundamentales;
* el modelo depende de un supuesto crítico sin evidencia;
* hay riesgos legales o de seguridad no resueltos;
* el alcance no puede delimitarse;
* la propuesta de valor es incoherente;
* el proyecto exige una decisión humana importante;
* la implementación produciría desperdicio significativo.

### Regla

`BLOCKED` no significa abandonar. Significa que el siguiente paso debe ser
validación o decisión, no implementación.

---

# 12. Diferencias nuevo vs. existente

## 12.1 Proyecto nuevo

Priorizar:

1. problema y evidencia;
2. actores y proceso actual;
3. alternativas y propuesta de valor;
4. experimentos de validación;
5. alcance pequeño.

No crear arquitectura ni código de producción.
Se permiten prototipos descartables para validar hipótesis.

## 12.2 Proyecto existente

Además de lo anterior:

* observar el comportamiento implementado;
* revisar métricas, feedback y tickets disponibles;
* identificar features sin uso y documentación divergente;
* mapear deuda de producto;
* detectar reglas embebidas solo en código;
* identificar dependencias operativas;
* distinguir comportamiento intencional de accidental.

**No intentar reescribir toda la documentación de una sola vez.**
Priorizar: (1) producto actual, (2) área en análisis, (3) contradicciones críticas,
(4) riesgos, (5) documentación necesaria para el siguiente cambio.

---

# 13. Reglas de documentación

## 13.1 No sobrescribir sin comprender

Antes de modificar un documento existente: leerlo completamente, identificar
su propósito, conservar decisiones vigentes, marcar información obsoleta,
evitar eliminar contexto útil, registrar cambios significativos.

## 13.2 No duplicar

Una información debe tener una **fuente principal**. Otros documentos deben
enlazarla, no copiarla. Ejemplo: permisos en `roles-and-permissions.md`;
cada feature referencia ese documento y agrega solo excepciones.

## 13.3 Mantener trazabilidad

Vincular siempre que sea posible:

```text
Problema → Actor → Resultado → Capacidad → Regla → Supuesto → Experimento → Decisión
```

## 13.4 Usar lenguaje normativo con precisión

| Término | Significado |
|---------|-------------|
| `Debe` | Requisito obligatorio |
| `No debe` | Prohibición |
| `Debería` | Recomendación fuerte |
| `Puede` | Opción permitida |
| `Pendiente` | No decidido |
| `Supuesto` | Requiere evidencia |
| `Fuera de alcance` | No se implementará en el incremento actual |

## 13.5 Idioma de la documentación

* Si el repositorio tiene documentación en inglés, mantener el inglés.
* Si el repositorio tiene documentación en español, mantener el español.
* Si no hay documentación previa, usar el idioma en que el usuario se comunica.
* **No mezclar idiomas** en el mismo artefacto.
* Los términos técnicos (JTBD, ADR, OKR, KPI) pueden mantenerse en inglés.

---

# 14. Prohibiciones

Durante esta skill, el agente **no debe**:

* implementar features, inicializar frameworks, instalar dependencias;
* diseñar tablas definitivas, crear endpoints, escribir componentes de producción;
* seleccionar tecnologías sin justificación derivada de requisitos;
* inventar entrevistas, métricas, evidencia;
* declarar validado un supuesto sin prueba;
* copiar funcionalidades de competidores sin analizar su propósito;
* crear personas decorativas;
* crear documentación enorme sin decisiones útiles;
* resolver silenciosamente contradicciones;
* aceptar todas las ideas del usuario sin cuestionarlas;
* ampliar el alcance sin registrarlo;
* transformar preferencias en requisitos;
* confundir restricciones técnicas con necesidades de usuario;
* confundir el roadmap con una lista de features;
* bloquearse por información menor faltante;
* realizar operaciones destructivas, modificar producción, acceder a secretos;
* prometer resultados comerciales no demostrados.

---

# 15. Stop conditions

El agente debe detener la progresión cuando:

* existe una decisión irreversible sin aprobación;
* se detecta una posible obligación legal crítica;
* existe riesgo grave de privacidad;
* no puede identificarse al usuario principal;
* dos requisitos centrales son incompatibles;
* no existe una definición coherente del problema;
* la propuesta depende de acceso a datos no garantizado;
* el modelo requiere una integración cuya disponibilidad es incierta;
* el producto podría facilitar abuso grave;
* el alcance excede claramente las restricciones;
* la documentación es insuficiente y no puede realizarse inferencia segura.

**Detener la progresión no significa dejar de trabajar.** Antes de detenerse debe:

1. completar todos los análisis no bloqueados;
2. documentar hallazgos;
3. explicar el bloqueo;
4. presentar alternativas;
5. recomendar la decisión;
6. actualizar `project-status.md`.

---

# 16. Anti-patrones del agente

## Señales de que el agente está fallando

El agente debe **autoevaluarse activamente** durante la ejecución. Si detecta
alguno de estos comportamientos, debe corregir inmediatamente:

### Análisis débil

* Está resumiendo la idea sin cuestionarla.
* Está produciendo una lista genérica de preguntas sin contexto.
* Está generando una lista extensa de features sin vincularlas a problemas.
* Está recomendando tecnologías en fase de discovery.
* Está creando personas ficticias sin evidencia.
* Está copiando patrones de empresas conocidas sin analizar si aplican.

### Complacencia

* Está diciendo que la idea es buena sin haberla sometido a crítica.
* Está aceptando todos los requisitos sin desafiar su necesidad.
* Está evitando señalar contradicciones por no incomodar.
* Está transformando preferencias del usuario en requisitos obligatorios.

### Dilación

* Está pidiendo al usuario que complete todo el análisis.
* Está produciendo documentos extensos sin priorización ni decisiones.
* Está iterando sobre detalles irrelevantes sin avanzar hacia el gate.
* Está evitando formular una recomendación clara.

### Exceso de confianza

* Está presentando inferencias como `Comprobado`.
* Está afirmando que algo funcionará sin evidencia.
* Está descartando riesgos porque "es obvio que se resolverán".
* Está recomendando PASS cuando hay supuestos críticos sin validar.

---

# 17. Criterios de calidad

La ejecución es de **alta calidad** cuando:

* distingue hechos de supuestos;
* cuestiona la solución propuesta;
* identifica actores omitidos, permisos, ownership, estados, edge cases;
* detecta costos operativos ocultos;
* detecta riesgos legales y de seguridad;
* conecta capacidades con resultados;
* elimina complejidad innecesaria;
* produce preguntas concretas y accionables;
* diseña experimentos verificables;
* mantiene documentación consistente;
* no invade arquitectura prematuramente;
* **termina con una recomendación clara y justificada**.

La ejecución es **insuficiente** cuando cae en cualquiera de los anti-patrones
descritos en la sección 16.

---

# 18. Checklist de autoevaluación

Antes de finalizar, el agente debe verificar:

## Problema

* [ ] Definido sin mencionar la solución.
* [ ] Actor afectado identificado.
* [ ] Frecuencia y severidad consideradas.
* [ ] Alternativas actuales documentadas.
* [ ] Consecuencias de no resolverlo conocidas.

## Actores

* [ ] Usuario y comprador diferenciados.
* [ ] Administradores, operadores y soporte identificados.
* [ ] Actores indirectos y sistemas externos considerados.

## Valor

* [ ] Propuesta de valor formulada con diferencia verificable.
* [ ] Resultado principal definido.
* [ ] Primera experiencia de valor identificada.

## Alcance

* [ ] Capacidades relacionadas con resultados.
* [ ] No objetivos definidos y dependencias identificadas.
* [ ] Complejidad especulativa eliminada.

## Reglas

* [ ] Ownership, tenancy, roles y permisos analizados.
* [ ] Estados, eliminación, restauración, límites y excepciones analizados.

## Riesgos

* [ ] Valor, usabilidad, viabilidad y factibilidad analizadas.
* [ ] Seguridad, privacidad, operación y soporte analizados.
* [ ] Riesgos críticos tienen respuesta (mitigación o bloqueo).

## Evidencia

* [ ] Hechos diferenciados de supuestos.
* [ ] Supuestos críticos con experimento diseñado.
* [ ] Criterios de éxito/fracaso definidos.
* [ ] No se inventó validación.

## Documentación

* [ ] Sin duplicaciones importantes, vocabulario consistente.
* [ ] Contradicciones registradas.
* [ ] `project-status.md` actualizado.
* [ ] Gate con justificación explícita.

---

# 19. Formato del informe final

La respuesta final del agente debe ser **breve** en comparación con la
documentación producida. Usar esta estructura:

```markdown
# Discover Product — Resultado

## Gate
PASS | CONDITIONAL PASS | BLOCKED

## Resumen en una frase
[Una sola frase que capture la esencia de la situación]

## Conclusión
[Párrafo breve con la situación del producto]

## Decisiones que requieren aprobación
1. …
2. …

## Riesgos críticos
1. …
2. …

## Supuestos prioritarios
1. …
2. …

## Contradicciones encontradas
1. …
2. …

## Alcance recomendado
[Resumen del incremento sugerido]

## Fuera de alcance
[Resumen de lo postergado o descartado]

## Evidencia faltante
1. …
2. …

## Documentos creados o actualizados
- `ruta`
- `ruta`

## Próxima acción
[Acción concreta]

## Próxima skill recomendada
`nombre-de-skill`
```

**No incluir una narración innecesaria de cada paso ejecutado.**

---

# 20. Invocación recomendada

## Forma directa

```text
Ejecuta la skill discover-product sobre este proyecto.

Lee primero AGENTS.md y toda la documentación relevante.
Trabaja de manera autónoma.
No implementes código. No selecciones stack. No comiences preguntándome.

Inspecciona primero todo el contexto disponible, realiza la revisión
completa y actualiza la documentación correspondiente.

Detente únicamente ante decisiones humanas críticas o irreversibles.
```

## Cuando el agente no soporta skills

```text
Lee y sigue estrictamente:
.agents/skills/discover-product/SKILL.md
Aplícala sobre todo el proyecto.
```

## Aplicación sobre una feature

```text
Aplica discover-product únicamente sobre la feature de suscripciones.
No redefinas el resto del producto salvo contradicción directa que deba documentarse.
```

## Proyecto existente

```text
Ejecuta discover-product sobre el producto existente.
Distingue cuidadosamente: comportamiento documentado, implementado, probado y esperado.
No modifiques código. No asumas que la documentación actual es correcta.
```

---

# 21. Handoff hacia la siguiente skill

Según el resultado, recomendar:

| Situación | Skill recomendada |
|-----------|-------------------|
| Falta evidencia sobre supuestos críticos | `validate-assumptions` |
| Producto demasiado amplio, necesita acotarse | `define-product-scope` |
| Producto definido, listo para estructura | `design-information-architecture` |
| Feature específica lista para especificar | `design-feature` |
| Producto existente con inconsistencias | `audit-existing-project` |
| Restricciones críticas de calidad sin definir | `define-quality-attributes` |

**No recomendar implementación directa** salvo que:

* el alcance esté aprobado;
* los comportamientos estén suficientemente definidos;
* los riesgos críticos estén controlados;
* las validaciones necesarias estén completas;
* exista una feature specification preparada.

---

# 22. Niveles de profundidad

No todos los proyectos necesitan las 25 etapas completas. El agente debe
seleccionar el nivel adecuado según el contexto:

## Nivel `quick` — Validación rápida (~etapas 1–7)

**Cuándo**: feature aislada, producto ya definido, validación previa a inversión pequeña.

Ejecutar: contexto, normalizar, problema, actores, jobs, proceso, alternativas.
Omitir o comprimir: capacidades detalladas, reglas, permisos, estados, edge cases.

## Nivel `medium` — Discovery estándar (~etapas 1–18)

**Cuándo**: producto nuevo de alcance moderado, redefinición parcial.

Ejecutar: todas las etapas hasta supuestos y experimentos.
Pueden fusionarse etapas consecutivas si la información ya existe.

## Nivel `thorough` — Discovery completo (25 etapas)

**Cuándo**: nuevo producto estratégico, inversión significativa, dominio complejo,
múltiples actores con permisos sofisticados, requisitos legales.

Ejecutar: todas las etapas sin excepción.

## Regla de selección

Si el agente no está seguro del nivel, **comenzar en `medium`** y escalar a
`thorough` si descubre complejidad inesperada durante las primeras etapas.

---

## Notas de versión

* v2.0: Reestructuración completa. Añadidos: resumen ejecutivo, anti-patrones,
  niveles de profundidad, manejo de desacuerdo, sesgos cognitivos, idioma de
  documentación, reglas de backtracking y fusión de etapas.
