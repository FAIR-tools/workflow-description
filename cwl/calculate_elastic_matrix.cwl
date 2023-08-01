cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- script.py
requirements:
  InitialWorkDirRequirement:
    listing:
    - entryname: script.py
      entry: "def calculate_elastic_matrix(structure='structure_file.data'):\n   \
        \ \n    from pyiron_base import Settings\n    s = Settings()\n    s._configuration['resource_paths'].append('/home/menon/pyiron/resources')\n\
        \    s._configuration['resource_paths'].append('/home/menon/miniconda3/envs/workflow-desc/share/iprpy')\n\
        \n    import numpy as np\n    \n    from pyiron import Project    \n    pr\
        \ = Project('elastic_constant')\n    job = pr.create.job.Lammps(job_name=\"\
        lammps_job\")\n    job.structure = pr.create.structure.ase.read(structure,\
        \ format='vasp')\n    job.potential = '2009--Mendelev-M-I--Al-Mg--LAMMPS--ipr1'\n\
        \    job.calc_minimize()\n    elastic_job = job.create_job(pr.job_type.ElasticMatrixJob,\
        \ \"elastic_job\")\n    elastic_job.input[\"eps_range\"] = 0.001\n    elastic_job.run()\n\
        \    np.savetxt(\"elastic_matrix.dat\", elastic_job[\"output/elasticmatrix\"\
        ][\"C\"])\n\nif __name__==\"__main__\":\n    calculate_elastic_matrix(structure\
        \ = \"$(inputs.structure)\",)"
    - $(inputs.structure_filename)
inputs:
  structure: string
outputs:
  elastic_matrix.dat:
    type: File
    outputBinding:
      glob: elastic_matrix.dat
