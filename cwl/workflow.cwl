#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

outputs:
  elastic_matrix:
    type: File
    outputSource: calculate_elastic_matrix/elastic_matrix

inputs:
  element: string

steps:
  create_structure:
    run: create_structure.cwl
    in:
      element: element
    out: [structure_file]

  calculate_elastic_matrix:
    run: calculate_elastic_matrix.cwl
    in:
      structure: create_structure/structure_file
    out: [elastic_matrix]