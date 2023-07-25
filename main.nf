nextflow.enable.dsl = 2

include { FASTP } from './modules/fastp.nf'

log.info """\
         RNAseq fastp analysis using NextFlow 
         =============================
         reads1 : ${params.reads1}
		 reads2 : ${params.reads2}
         outdir: ${params.outdir}
         """
         .stripIndent()

workflow {

    Channel.fromPath(params.reads1, checkIfExists: true).set{ reads1 }
	Channel.fromPath(params.reads2, checkIfExists: true).set{ reads2 }

	FASTP( reads1 )
	FASTP( reads2 )

}
