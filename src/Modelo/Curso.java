package Modelo;

import Banco.*;

public class Curso {
	
	private String codigo;
	private String nome;
	private String coordenador;

	public Curso(String codigo, String nome, String coordenador) {
		this.codigo = codigo;
		this.nome = nome;
		this.coordenador = coordenador;
	}


	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCoordenador() {
		return coordenador;
	}

	public void setCoordenador(String coordenador) {
		this.coordenador = coordenador;
	}


}