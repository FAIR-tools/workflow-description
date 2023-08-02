
from pyiron_base import Settings
s = Settings()
s._configuration['resource_paths'].append('/home/menon/pyiron/resources')
s._configuration['resource_paths'].append('/home/menon/miniconda3/envs/workflow-desc/share/iprpy')

import numpy as np

from pyiron import Project    
pr = Project('elastic_constant')
job = pr.create.job.Lammps(job_name="lammps_job")
job.structure = pr.create.structure.ase.read(snakemake.input[0], format='vasp')
job.potential = '2009--Mendelev-M-I--Al-Mg--LAMMPS--ipr1'
job.calc_minimize()
elastic_job = job.create_job(pr.job_type.ElasticMatrixJob, "elastic_job")
elastic_job.input["eps_range"] = 0.001
elastic_job.run()
np.savetxt(snakemake.output[0], elastic_job["output/elasticmatrix"]["C"])