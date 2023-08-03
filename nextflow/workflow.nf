#!/usr/bin/env nextflow
nextflow.enable.dsl=2
element = Channel.from('Al')
prefix = Channel.from('/srv/conda/envs/notebook/')

process createStructure {
    input:
    val element
    val prefix

    output:
    path 'structure_file.data'

    """
    #!$prefix/bin/python

    from pyiron_base import Settings
    s = Settings()
    s._configuration['resource_paths'].append('/home/menon/pyiron/resources')
    from pyiron import Project
    pr = Project("elastic_constant")
    structure = pr.create.structure.bulk("$element", 
                                         cubic=True)
    outfile = "structure_file.data"
    structure.write(outfile, format="vasp")
    """
}

process calculateElasticMatrix {
    input:
    path structure_file
    val prefix

    output:
    path 'elastic_matrix.dat'

    """
    #!$prefix/bin/python
    
    from pyiron_base import Settings
    s = Settings()
    s._configuration['resource_paths'].append('$prefix/share/pyiron')
    s._configuration['resource_paths'].append('$prefix/share/iprpy')


    import numpy as np
    from pyiron import Project    
    pr = Project('elastic_constant')
    job = pr.create.job.Lammps(job_name="lammps_job")
    job.structure = pr.create.structure.ase.read("$structure_file", format='vasp')
    job.potential = '2009--Mendelev-M-I--Al-Mg--LAMMPS--ipr1'
    job.calc_minimize()
    elastic_job = job.create_job(pr.job_type.ElasticMatrixJob, "elastic_job")
    elastic_job.input["eps_range"] = 0.001
    elastic_job.run()
    np.savetxt("elastic_matrix.dat", elastic_job["output/elasticmatrix"]["C"])
    """    
}


workflow {
   createStructure(element, prefix)
   calculateElasticMatrix(createStructure.out, prefix)
}