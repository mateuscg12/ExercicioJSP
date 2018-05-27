package Banco;

import java.util.*;
import Modelo.*;



public class DBA {
    
    private static ArrayList<Aluno> objeto = new ArrayList<Aluno>();
    private static DBA INSTANCE = new DBA();
    
    public DBA(){
        
    }
    
    public static DBA getInstance(){
        return DBA.INSTANCE;
    }
    
    public void inserir(Aluno aluno) {
        String matricula = aluno.getMatricula();

        boolean existe = false;

        for(int i = 0; i < objeto.size(); i++){

            if(objeto.get(i).getMatricula().equalsIgnoreCase(matricula)){
                existe = true;

            }
        }
        if(!existe){
            objeto.add(aluno);
        }

    }

    public void remover(Aluno aluno) {
        objeto.remove(aluno);
    }
    public List<Aluno> listar(){
        return objeto;
    }

}