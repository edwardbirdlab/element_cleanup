process FASTP_SE {
    label 'lowmem'
    container 'ebird013/fastp:latest'

    input:
        tuple val(sample), file(R1), file(adapter_fasta)

    output:
        tuple val(sample), path("${sample}_R1.fq.gz"), emit: trim
        tuple val(sample), path("${sample}.fastp.html"), emit: html
        tuple val(sample), path("${sample}.fastp.json"), emit: json
        path("versions.yml"), emit: versions


    script:

    """
    fastp -i ${R1} -o ${sample}_R1.fq.gz -q ${params.fastp_q} -l ${params.fastp_minlen} --json ${sample}.fastp.json --html ${sample}.fastp.html --adapter_fasta ${adapter_fasta}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
    fastp: \$(fastp -v 2>&1 | grep "fastp" | sed -e "s/fastp //g")
    END_VERSIONS
    """
}

process FASTP_PE {
    label 'lowmem'
    container 'ebird013/fastp:latest'

    input:
        tuple val(sample), file(R1), file(R2), file(adapter_fasta)

    output:
        tuple val(sample), path("${sample}_R1.fq.gz"), path("${sample}_R2.fq.gz"), emit: trim
        tuple val(sample), path("${sample}.fastp.html"), emit: html
        tuple val(sample), path("${sample}.fastp.json"), emit: json
        path("versions.yml"), emit: versions


    script:

    """
    fastp -i ${R1} -I ${R2} -o ${sample}_R1.fq.gz -O ${sample}_R2.fq.gz -q ${params.fastp_q} -l ${params.fastp_minlen} --json ${sample}.fastp.json --html ${sample}.fastp.html --adapter_fasta ${adapter_fasta}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
    fastp: \$(fastp -v 2>&1 | grep "fastp" | sed -e "s/fastp //g")
    END_VERSIONS
    """
}