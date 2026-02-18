# Descripció de les variables

Aquest fitxer descriu les variables del conjunt de dades sintètiques òmiques de l'exercici 2.

| Variable | Tipus | Descripció |
|---|---|---|
| `sample_id` | Numèrica entera | Identificador de la mostra. Es numera de l'1 al 120. |
| `condition` | Numèrica binària | Estat clínic de la mostra: `0 = Control`, `1 = Case`. |
| `batch` | Numèrica categòrica codificada | Lot experimental: `1 = B1`, `2 = B2`, `3 = B3`. |
| `sex` | Numèrica binària | Sexe biològic: `0 = F`, `1 = M`. |
| `age` | Numèrica contínua | Edat de l'individu en anys. |
| `bmi` | Numèrica contínua | Índex de massa corporal. |
| `gene_TP53` | Numèrica contínua | Expressió sintètica del gen TP53. |
| `gene_EGFR` | Numèrica contínua | Expressió sintètica del gen EGFR. |
| `gene_BRCA1` | Numèrica contínua | Expressió sintètica del gen BRCA1. |
| `prot_IL6` | Numèrica contínua | Nivell sintètic de la proteïna IL6. |
| `prot_CRP` | Numèrica contínua | Nivell sintètic de la proteïna CRP. |
| `meth_PROM1` | Numèrica contínua | Valor sintètic de metilació del locus PROM1, restringit aproximadament entre 0 i 1. |
| `metab_lactate` | Numèrica contínua | Concentració sintètica de lactat metabòlic. |
| `rnaseq_qc_reads_m` | Numèrica contínua | Milions de lectures de control de qualitat de RNA-seq. |

## Notes

- Les variables categòriques han estat recodificades a valors numèrics per facilitar l'ús en gràfics i anàlisis.
- El fitxer CSV associat és [data.csv](data.csv).
- Aquest conjunt de dades és sintètic i ha estat generat amb finalitat docent.
