# workflow_languages

Compare workflow languages or specifications, and connect it to a typical pyiron workflow

## Use case 1

Calculate Young's modulus of Al.

Molecular statics will be used for the calculation with LAMMPS as the tool.
The interatomic potential used is the following:

M.I. Mendelev, M. Asta, M.J. Rahman, and J.J. Hoyt (2009), "Development of interatomic potentials appropriate for simulation of solid-liquid interface properties in Al-Mg alloys", Philosophical Magazine, 89(34-36), 3269-3285. DOI: 10.1080/14786430903260727.

See the implementation:

- [pyiron](pyiron/workflow.ipynb)
- [pyiron-workflow](pyiron-workflow/workflow.ipynb)
- [Common Workflow Language](cwl/execute_cwl.ipynb)
- [Nextflow](nextflow/execute_nextflow.ipynb)
- [Snakemake](snakemake/execute_snakemake.ipynb)