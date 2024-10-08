package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model;

public enum Gender {
	
	MASCULINO("Masculino"),
	FEMININO("Feminino"),
	OUTRO("Outro"),
	PREFIRO_NAO_DIZER("Prefiro não dizer");
	
	private final String description;
	
	Gender(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}
}
