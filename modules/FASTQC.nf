process FASTQC_PE {
    label 'ultralow'
	container 'ebird013/fastqc:0.12.1_custom'

    input:
        tuple val(sample), file(R1), file(R2), file(adapter_fasta)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq
        path("versions.yml"), emit: versions


    script:


    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} ${R1} ${R2} -a ${adapter_fasta}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        fastqc: \$(fastqc --version 2>&1 | grep "FastQC" | sed -e "s/FastQC //g")
    END_VERSIONS 
    """
}

process FASTQC_SE {
    label 'ultralow'
    container 'ebird013/fastqc:0.12.1_custom'

    input:
        tuple val(sample), file(R1), file(adapter_fasta)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq
        path("versions.yml"), emit: versions


    script:


    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} ${R1} -a ${adapter_fasta}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        fastqc: \$(fastqc --version 2>&1 | grep "FastQC" | sed -e "s/FastQC //g")
    END_VERSIONS 
    """
}