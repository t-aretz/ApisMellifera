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

    // Create channels for read 1 and read 2 files
    val read1_ch = Channel.fromFilePairs(params.reads1, checkIfExists: true)
    val read2_ch = Channel.fromFilePairs(params.reads2, checkIfExists: true)

    // Combine read 1 and read 2 channels using 'merge' or 'combine' function
    val combined_reads = read1_ch.combine(read2_ch)

    // Pipe the combined channels to the FASTP process
    combined_reads | FASTP

}
