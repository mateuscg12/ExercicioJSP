package Banco;

import java.util.*;
import Modelo.*;



public class DBC {
	
	private ArrayList<Curso> objeto = new ArrayList<Curso>();
	private static DBC INSTANCE = new DBC();
	
	public DBC(){
//		Curso sistema = new Curso("1", "Sistemas da informação", "Vera");
//		inserir(sistema);
	}
	
	public static DBC getInstance(){
		return DBC.INSTANCE;
	}
	
	public void inserir(Curso curso) {

		String matricula = curso.getCodigo();

		boolean existe = false;

		for(int i = 0; i < objeto.size(); i++){

			if(objeto.get(i).getCodigo().equalsIgnoreCase(matricula)){
				existe = true;

			}
		}
		if(!existe){
			objeto.add(curso);
		}
	}

	public void remover(Curso curso) {
		objeto.remove(curso);
	}
	public List<Curso> listar(){
		return objeto;
	}

}