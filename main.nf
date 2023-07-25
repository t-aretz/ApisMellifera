nextflow.enable.dsl = 2

include { FASTP } from './modules/fastp.nf'

log.info """\
         RNAseq fastp analysis using NextFlow 
         =============================
         reads : ${params.reads}
         outdir: ${params.outdir}
         """
         .stripIndent()

workflow {

    Channel.fromFilePairs(params.reads, checkIfExists: true).set{ read_pairs_unsplit_ch }

    FASTP( read_pairs_unsplit_ch )

	process split_fastq_unzipped {

	    input:
	    tuple val(name), path(fastq)
	
	    output:
	    tuple val(name), path("${name}_1-${/[0-9]/*params.suffix_length}.fq"), path("${name}_2-${/[0-9]/*params.suffix_length}.fq")
	
	    script:
	    """
	    cat ${fastq[0]} | split \\
	        -a ${params.suffix_length} \\
	        -d \\
	        -l ${params.num_lines} \\
	        - \\
	        ${fastq[0].getBaseName()}- \\
	        --additional-suffix=".fq"
	}

	split_fastq_unzipped(FASTP.out.sample_trimmed) \
	| map { name, fastq, fastq1 -> tuple( groupKey(name, fastq.size()), fastq, fastq1 ) } \
        | transpose() \
        | view()
        | set{ read_pairs_ch }
	

}
