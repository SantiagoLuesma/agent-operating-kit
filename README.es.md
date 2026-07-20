# Kit operativo para agentes

**Idioma:** [English](./README.md) · **Español**

Proceso portable + skills + esqueleto de documentación para construir software
con agentes de código — independiente de cualquier proveedor de modelos o
cliente.

**Autor:** [Santiago Luesma](https://github.com/SantiagoLuesma) ([@luesmaaa](https://x.com/luesmaaa))  
**Licencia:** [MIT](./LICENSE) · Copyright (c) 2026 Santiago Luesma  

Uso público seguro: este repositorio **no** incluye secretos de aplicaciones,
API keys ni credenciales de producción.

Este repositorio **no** es un starter de aplicación (no trae stack). Es el
**sistema operativo compartido** que copias a tus proyectos para que todo
agente de código siga las mismas reglas, estándares de evidencia y flujo de
entrega.

Todo el diseño, la metodología y el empaquetado de este kit son de
**Santiago Luesma**. Ningún modelo ni proveedor externo es autor o coautor.

| Pieza | Rol |
| --- | --- |
| `AGENTS.md` | Reglas canónicas para cualquier agente |
| `.agents/skills/` | Procedimientos reutilizables (`SKILL.md`) |
| `profiles/` | Rigor: `quick` / `standard` / `full` |
| `docs/` | Producto, UX, arquitectura, planes, handoffs |
| `scripts/` | Puntos de verificación deterministas |
| `CLAUDE.md` / `adapters/` | Adaptadores delgados de cliente (opcionales) |
| `VERSION` | Versión del kit a registrar en cada proyecto |

Versión actual del kit: **0.3.5** — ver [`VERSION`](./VERSION) y [`CHANGELOG.md`](./CHANGELOG.md).

Completitud del kit: [`docs/kit/completeness.md`](./docs/kit/completeness.md)  
Nivel A = empaquetado · Nivel B = dry-run (`./scripts/smoke-level-b`, informe en
[`docs/kit/level-b-report.md`](./docs/kit/level-b-report.md)).

## Principios

1. **Repositorio > chat.** La documentación y el código mandan sobre el historial de conversación.
2. **Un solo workflow.** No forks de proceso por marca de modelo o cliente.
3. **Adaptadores delgados.** Los archivos opcionales de cliente solo apuntan a `AGENTS.md` + skills.
4. **Skills por ruta.** Si no hay auto-descubrimiento:  
   `.agents/skills/<nombre>/SKILL.md`.
5. **Evidencia.** Nunca declarar éxito sin checks ejecutados en la revisión correcta.
6. **Gates humanos.** Alcance, operaciones irreversibles, merge y producción los decide una persona.

## Inicio rápido para agentes

```text
1. Leer AGENTS.md
2. Leer docs/project-status.md
3. Elegir profiles/quick.md | standard.md | full.md
4. Listar .agents/skills/ y ejecutar la skill que corresponda
5. Actualizar docs cuando cambien decisiones y evidencia
```

Prompt genérico para pegar: [`adapters/generic-prompt.md`](./adapters/generic-prompt.md).

## Bootstrap de un proyecto nuevo

```bash
# Desde este repositorio del kit:
./scripts/bootstrap-project /ruta/al/proyecto

# O sobrescribiendo archivos gestionados por el kit:
./scripts/bootstrap-project /ruta/al/proyecto --force
```

El bootstrap copia la superficie completa del kit: `AGENTS.md`, `SECURITY.md`,
skills, perfiles, adapters, scripts, **todos los esqueletos/templates de docs**,
contratos, plantilla de PR, workflow de CI del kit y `docs/kit-version.md`.
La guía del kit se guarda como `README.kit.md`; si falta, se crea un
`README.md` corto del proyecto.

Después:

1. Edita `docs/project-status.md` del producto.
2. Ejecuta `./scripts/check-docs` en el destino.
3. Conecta checks del stack: `cp scripts/project-verify.example scripts/project-verify`.
4. Ejecuta `discover-product` o `audit-existing-project` según corresponda.

Primera skill recomendada:

| Situación | Skill |
| --- | --- |
| Idea nueva (greenfield) | `discover-product` |
| Código existente | `audit-existing-project` |

Luego congela el alcance del incremento con `define-product-scope` antes de
diseñar en profundidad.

## Bootstrap en un repo ya existente

1. Copia `AGENTS.md`, `.agents/skills`, `profiles`, `scripts`, templates (o usa el script).
2. **No** sobrescribas docs de producto existentes a ciegas.
3. Ejecuta `audit-existing-project`.
4. Rellena `docs/project-status.md` solo con hechos **verificables**.
5. Documenta módulos legados **cuando los toques**, no todo de una vez.

## Actualizar el kit en un proyecto en marcha

| Seguro refrescar a menudo | Cuidado al mezclar |
| --- | --- |
| `.agents/skills/**` | `AGENTS.md` si lo personalizaste |
| `profiles/**`, `adapters/**` | `docs/product`, features, etc. del proyecto |
| Entrypoints de `scripts/*` | CI propio de la app |

Las convenciones solo del proyecto van en la sección `## Project-specific` al
final de `AGENTS.md`. No debilites las reglas centrales del kit.

## Perfiles de rigor

| Perfil | Cuándo |
| --- | --- |
| [`profiles/quick.md`](./profiles/quick.md) | Bug claro, chore, bajo riesgo |
| [`profiles/standard.md`](./profiles/standard.md) | Trabajo de feature por defecto |
| [`profiles/full.md`](./profiles/full.md) | Dominio nuevo, alta incertidumbre, seguridad/datos críticos |

Default para trabajo de producto no trivial: **standard**.

## Catálogo de skills

Inventario vivo: `.agents/skills/*/SKILL.md`.

| Situación | Skill |
| --- | --- |
| Producto nuevo o poco claro | `discover-product` |
| Código heredado | `audit-existing-project` |
| Validar supuestos críticos | `validate-assumptions` |
| Congelar alcance del incremento | `define-product-scope` |
| Arquitectura de información | `design-information-architecture` |
| Atributos de calidad | `define-quality-attributes` |
| Diseñar arquitectura | `design-architecture` |
| Revisar arquitectura | `review-architecture` |
| Walking skeleton | `build-walking-skeleton` |
| Diseñar una feature | `design-feature` |
| Revisar diseño de feature | `review-feature` |
| Plan de ejecución | `create-exec-plan` |
| Implementar un slice | `implement-vertical-slice` |
| Verificar aceptación | `verify-acceptance-criteria` |
| Revisar el cambio | `review-change` |
| Revisión de seguridad | `review-security` |
| Revisión de migración | `review-migration` |
| Sincronizar documentación | `update-documentation` |
| Handoff de sesión | `generate-handoff` |
| Preparar pull request | `prepare-pr` |
| Verificar rama de integración | `verify-main` |
| Preparar release | `prepare-release` |

## Estructura

```text
AGENTS.md                 # constitución
CLAUDE.md                 # adaptador opcional de cliente
TOOLING.md                # baseline vs enhancers
VERSION
profiles/                 # quick | standard | full
adapters/                 # prompts genéricos
.agents/skills/           # inventario canónico de skills
docs/
  project-status.md
  product/scope.md        # ruta canónica de alcance
  features/_templates/
  plans/_templates/
  handoffs/_templates/
  decisions/adr/_template.md
scripts/
  check-docs
  verify
  test
  list-skills
  bootstrap-project
  project-verify.example
docs/kit/scripts.md       # contratos de scripts
```

## Validación

```bash
./scripts/check-docs
./scripts/verify
./scripts/test            # NOT CONFIGURED hasta que exista stack
./scripts/list-skills
./scripts/smoke-level-b   # dry-run Nivel B (bootstrap + quick + standard)

# Cuando exista stack de app, forzar hooks en CI:
STRICT=1 ./scripts/verify
STRICT=1 ./scripts/test
```

Contratos de scripts: [`docs/kit/scripts.md`](./docs/kit/scripts.md).

CI de este repo: [`.github/workflows/kit-ci.yml`](./.github/workflows/kit-ci.yml).

## Flujo Git de este repo del kit

| Rama / ref | Propósito |
| --- | --- |
| `version-original` / tag `original-baseline` | Snapshot previo al empaquetado |
| `grok` (o ramas de feature) | Desarrollo del kit |
| `main` | Rama de integración del kit |

## Gates de aprobación humana

1. Alcance y comportamiento  
2. Decisiones irreversibles (auth, tenancy, billing, datos, secretos, prod)  
3. Merge del pull request  
4. Producción / migración destructiva  

## Autor

| | |
| --- | --- |
| Nombre | Santiago Luesma |
| GitHub | [@SantiagoLuesma](https://github.com/SantiagoLuesma) |
| X / Twitter | [@luesmaaa](https://x.com/luesmaaa) |

## Licencia / propiedad

Publicado bajo la [licencia MIT](./LICENSE).  
Copyright (c) 2026 Santiago Luesma. Todo el crédito de este kit pertenece al autor.
