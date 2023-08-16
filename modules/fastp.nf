process FASTP {
    tag "$tasks"
    label 'fastp'
    publishDir params.outdir

    input:
    tuple val(name), path(reads), val(tasks)

    output:
    tuple val(name), path("${name}*.trimmed.fastq"), val(filesize) emit: sample_trimmed
    path "${name}_fastp.json", emit: report_fastp_json
    path "${name}_fastp.html", emit: report_fastp_html

    script:
    def fileSize = new File(reads).length() / (1024 * 1024) // Size in MB
    """
    echo "${fileSize.toFixed(2)}"
    echo $tasks
    fastp -i ${reads} -o ${name}.R1.trimmed.fastq --detect_adapter_for_pe --json ${name}_fastp.json --html ${name}_fastp.html --thread ${params.threads}
    """
}
