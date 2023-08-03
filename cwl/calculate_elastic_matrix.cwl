cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- script.py
requirements:
  InitialWorkDirRequirement:
    listing:
    - entryname: script.py
      entry: |-
        from pyiron_base import Settings
        s = Settings()
        s._configuration['resource_paths'].append('$(inputs.prefix)/share/pyiron')
        s._configuration['resource_paths'].append('$(inputs.prefix)/share/iprpy')

        import numpy as np

        from pyiron import Project    
        pr = Project('elastic_constant')
        job = pr.create.job.Lammps(job_name="lammps_job")
        job.structure = pr.create.structure.ase.read("$(inputs.structure.path)", format='vasp')
        job.potential = '2009--Mendelev-M-I--Al-Mg--LAMMPS--ipr1'
        job.calc_minimize()
        elastic_job = job.create_job(pr.job_type.ElasticMatrixJob, "elastic_job")
        elastic_job.input["eps_range"] = 0.001
        elastic_job.run()
        np.savetxt("elastic_matrix.dat", elastic_job["output/elasticmatrix"]["C"])

inputs:
  structure: File
  prefix: string
outputs:
  elastic_matrix:
    type: File
    outputBinding:
      glob: elastic_matrix.dat
