process STAR_INDEX_REFERENCE {
    label 'star'
    publishDir params.outdir
 
    input:
    path(reference)
    path(annotation)

    output:
    path("star/*")

    script:
    """
    mkdir star
    STAR \\
            --runMode genomeGenerate \\
            --genomeDir star/ \\
	        --genomeFastaFiles ${reference} \\
            --sjdbGTFfile ${annotation} \\
	        --runThreadN ${params.threads}
    """
}

process STAR_ALIGN {
    label 'star'
    publishDir params.outdir
 
    input:
    tuple val(sample_name), path(reads_1)
    path(index)
    path(annotation)

    output:
    tuple val(sample_name), path("${reads_1.getBaseName()}*.sam"), emit: sample_sam 

    shell:
    '''
       STAR \\
          --genomeDir . \\
          --readFilesIn !{reads} \\
          --alignSoftClipAtReferenceEnds No \\
          --outSAMstrandField intronMotif \\
          --outFileNamePrefix !{reads_1.getBaseName()}. \\
          --sjdbGTFfile !{annotation} \\
          --outFilterIntronMotifs RemoveNoncanonical \\
          --outSAMattrIHstart 0
    '''   
   
}
