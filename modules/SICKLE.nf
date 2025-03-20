process SICKLE_SE {
    label 'verylow'
	container 'docker://ebird013/sickle:latest'

    input:
        tuple val(sample), file(R1)
    output:
	    tuple val(sample), path("${sample}_trim.fastq.gz"), emit: trim
        path("versions.yml"), emit: versions


    script:

    """
    sickle se -f ${R1} -t ${params.sickle_type} -o ${sample}_trim.fastq.gz -q ${params.sickle_qual} -l ${params.sickle_len} -g \\
    ${params.sickle_additional_args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        fastp: \$(fastp -v 2>&1 | grep "fastp" | sed -e "s/fastp //g")
    END_VERSIONS  
    """
}