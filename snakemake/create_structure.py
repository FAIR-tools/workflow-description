import yaml
with open(snakemake.input[0], 'r') as fin:
    data = yaml.safe_load(fin)
    
from pyiron_base import Settings
s = Settings()
s._configuration['resource_paths'].append('/home/menon/pyiron/resources')

from pyiron import Project
pr = Project("elastic_constant")
structure = pr.create.structure.bulk(data["element"], 
                                     cubic=True)
outfile = "structure_file.data"
structure.write(outfile, format="vasp")
