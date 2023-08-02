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
        def create_structure(element='Al'):\n    \"\"\"\n    Create an alloy\
        \ structure\n    \"\"\"\n    from pyiron_base import Settings\n    s = Settings()\n\
        \    s._configuration['resource_paths'].append('/home/menon/pyiron/resources')\n\
        \    from pyiron import Project\n    pr = Project(\"elastic_constant\")\n\
        \    structure = pr.create.structure.bulk(element, \n                    \
        \                     cubic=True)\n    outfile = \"structure_file.data\"\n\
        \    structure.write(outfile, format=\"vasp\")\n    return outfile\n\nif __name__==\"\
        __main__\":\n    create_structure(element = \"$(inputs.element)\",)"
inputs:
  element: string
outputs:
  structure_file:
    type: File
    outputBinding:
      glob: structure_file.data
