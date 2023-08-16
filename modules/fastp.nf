process FASTP {
    tag "$name"
    label 'fastp'
    publishDir params.outdir

    input:
    tuple val(name), path(reads), val(tasks)

    output:
    tuple val(name), path("${name}*.trimmed.fastq"), emit: sample_trimmed
    path "${name}_fastp.json", emit: report_fastp_json
    path "${name}_fastp.html", emit: report_fastp_html

    script:
    """
    echo $name
    fastp -i ${reads} -o ${name}.R1.trimmed.fastq --detect_adapter_for_pe --json ${name}_fastp.json --html ${name}_fastp.html --thread ${params.threads}
    """
}
