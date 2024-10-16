package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model;

public enum Status {
    IN_APROVAL("Em Apravação"),
    IN_PROGRESS("Em Progresso"),
    FINISHED("Finalizado"),
    APPROVED("Aprovado");

    private final String description;

    Status(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
