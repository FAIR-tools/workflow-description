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
        
        from pyiron import Project
        pr = Project("elastic_constant")
        structure = pr.create.structure.bulk("$(inputs.element)", 
                                             cubic=True)
        outfile = "structure_file.data"
        structure.write(outfile, format="vasp")

inputs:
  element: string
  prefix: string
outputs:
  structure_file:
    type: File
    outputBinding:
      glob: structure_file.data
