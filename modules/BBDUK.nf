process BBDUK_SE {
    label 'verylow'
	container 'ebird013/bbmap:latest'

    input:
        tuple val(sample), file(R1), file(adapter_fasta)
    output:
	    tuple val(sample), path("${sample}_filt.fastq.gz"), emit: trim
        tuple val(sample), path("${sample}_bbduk_stats.txt"), emit: stats
        path("versions.yml"), emit: versions


    script:

    """
    bbduk.sh in=${R1} out=${sample}_filt.fastq.gz ref=${adapter_fasta} ktrim=${params.bbduk_ktrim} hdist=${params.bbduk_hdist} threads=${task.cpus} stats=${sample}_bbduk_stats.txt \\
    ${params.bbduk_additional_args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        bbmap: \$(bbmap.sh version 2>&1 | grep "BBMap version" | sed -e "s/BBMap version //g")
    END_VERSIONS
    """
}