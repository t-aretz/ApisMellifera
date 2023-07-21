process FASTP {
    label 'fastp'
    publishDir params.outdir

    input:
    val(name)
    path(reads1)
    path(reads2)

    output:
    tuple val(name), file("${name}.R1.trimmed.fastq"), file("${name}.R2.trimmed.fastq"), emit: sample_trimmed
    file "${name}_fastp.json", emit: report_fastp_json
    file "${name}_fastp.html", emit: report_fastp_html

    script:
    """
    fastp -i ${reads[0]} -I ${reads[1]} -o ${name}.R1.trimmed.fastq -O ${name}.R2.trimmed.fastq --detect_adapter_for_pe --json ${name}_fastp.json --html ${name}_fastp.html --thread ${params.threads}
    """
}
