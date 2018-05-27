<%@page import="Modelo.*"%>
<%@page import="Banco.*"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    DBC dbc = DBC.getInstance();
    DBA dba = DBA.getInstance();

%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="">

    <title>Controle De Alunos</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300" rel="stylesheet">
    <style type="text/css">
        *{
            font-family: 'Source Sans Pro', sans-serif;
        }
        .col-sm-12{
            display: flex;
            flex-direction: column;
        }

        .title{
            height: 25vh;
            display: flex;
            width: 100%;
            justify-content: center;
            align-items: center;
        }
        .action{
            margin: 30px 0;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }
    </style>
</head>


<body>
<%

    if(request.getMethod().equalsIgnoreCase("POST")){

        String form = request.getParameter("submit");

        switch (form){
            case "Salvar Aluno":
                String matriculaAluno = request.getParameter("matriculaDoAluno");
                String nomeAluno = request.getParameter("nomeDoAluno");
                int indexCurso = Integer.parseInt(request.getParameter("indexCurso"));

                Curso cursoDoAluno = dbc.listar().get(indexCurso);
                Aluno novoAluno = new Aluno(matriculaAluno,nomeAluno, cursoDoAluno);

                dba.inserir(novoAluno);
                break;


            case "Salvar Curso":

                String matriculaCurso = request.getParameter("matriculaDoCurso");
                String nomeCurso = request.getParameter("nomeDoCurso");
                String nomeCoord = request.getParameter("nomeDoCoordenador");

                Curso novoCurso = new Curso(matriculaCurso, nomeCurso, nomeCoord);

                dbc.inserir(novoCurso);
                break;
        }
    }

    if(request.getMethod().equalsIgnoreCase("GET")){

        if(request.getParameter("apagarAluno") != null) {

            int indexApagar = Integer.parseInt(request.getParameter("apagarAluno"));
            Aluno alunoApagar = dba.listar().get(indexApagar);
            dba.remover(alunoApagar);

        }else if(request.getParameter("apagarCurso") != null){
            int indexApagar = Integer.parseInt(request.getParameter("apagarCurso"));
            Curso cursoApagar = dbc.listar().get(indexApagar);
            dbc.remover(cursoApagar);
        }
    }

%>

<div class="container">
    <div class="col-sm-12">

        <div class="title">
            <h1>Controle De Alunos:</h1>
        </div>
        <div class="action">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#novoAluno">+ Aluno</button>
        </div>
        <div class="table">

            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Matricula</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Curso</th>
                    <th scope="col">Apagar</th>
                </tr>
                </thead>
                <tbody>
                <%

                    List<Aluno> alunosLista = dba.listar();

                    for(int i = 0; i < alunosLista.size(); i++){
                %>
                <tr>
                    <th scope="row"><%=alunosLista.get(i).getMatricula() %></th>
                    <td><%=alunosLista.get(i).getNome() %></td>
                    <td><%=alunosLista.get(i).getCurso().getNome() %></td>
                    <td><a href="index.jsp?apagarAluno=<%= i %>" class="btn btn-danger btn-sm">Apagar</a></td>
                </tr>
                <%
                    }
                %>



                </tbody>
            </table>
        </div>


        <div class="title">
            <h1>Controle De Cursos:</h1>
        </div>
        <div class="action">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#novoCurso">+ Curso</button>
        </div>
        <div class="table">

            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Coordenador</th>
                    <th scope="col">Apagar</th>
                </tr>
                </thead>
                <tbody>
                <%

                    List<Curso> cursosLista = dbc.listar();

                    for(int i = 0; i < cursosLista.size(); i++){
                %>
                <tr>
                    <th scope="row"><%=cursosLista.get(i).getCodigo() %></th>
                    <td><%=cursosLista.get(i).getNome() %></td>
                    <td><%=cursosLista.get(i).getCoordenador() %></td>
                    <td><a href="index.jsp?apagarCurso=<%= i %>" class="btn btn-danger btn-sm">Apagar</a></td>
                </tr>

                <%
                    }
                %>



                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->




<div class="modal fade" id="novoAluno" tabindex="-1" role="dialog" aria-labelledby="ModalAluno" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalAluno">Novo Aluno</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body container">
                <form action="" method="post">
                    <div class="form-group">
                        <label for="matriculaDoAluno">
                            Matricula Do Aluno
                        </label>
                        <input type="text" class="form-control" id="matriculaDoAluno" placeholder="Digite a matricula do aluno" name="matriculaDoAluno" required>
                    </div>
                    <div class="form-group">
                        <label for="nomeDoAluno">
                            Nome Do Aluno
                        </label>
                        <input type="text" class="form-control" id="nomeDoAluno" placeholder="Digite o nome do aluno" name="nomeDoAluno" required>
                    </div>
                    <div class="form-group">
                        <label for="listaDeCursos">Curso
                        </label>
                        <select class="form-control" id="listaDeCursos" name="indexCurso">

                            <%

                                for(int i = 0; i < cursosLista.size(); i++){
                            %>
                            <option value="<%= i %>"><%=cursosLista.get(i).getNome() %></option>
                            <%
                                }
                            %>

                        </select>
                    </div>
                    <div class="modal-footer">
                        <input type="reset" class="btn btn-danger" value="Apagar">
                        <input type="submit" class="btn btn-primary" name="submit" value="Salvar Aluno">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>




<!-- Modal Curso-->





<div class="modal fade" id="novoCurso" tabindex="-1" role="dialog" aria-labelledby="ModalAluno" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalAluno">Novo Curso</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body container">
                <form action="" method="post">
                    <div class="form-group">
                        <label for="matriculaDoCurso">
                            Matricula Do Curso
                        </label>
                        <input type="text" class="form-control" id="matriculaDoCurso" placeholder="Digite a matricula do curso" name="matriculaDoCurso" required>
                    </div>
                    <div class="form-group">
                        <label for="nomeDoCurso">
                            Nome Do Curso
                        </label>
                        <input type="text" class="form-control" id="nomeDoCurso" placeholder="Digite o nome do curso" name="nomeDoCurso" required>
                    </div>
                    <div class="form-group">
                        <label for="nomeDoCoordenador">
                            Nome Do Coordenador
                        </label>
                        <input type="text" class="form-control" id="nomeDoCoordenador" placeholder="Digite o nome do coordenador" name="nomeDoCoordenador" required>
                    </div>
                    <div class="modal-footer">
                        <input type="reset" class="btn btn-danger" value="Apagar">
                        <input type="submit" class="btn btn-primary" name="submit" value="Salvar Curso">
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>

<!-- /.container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>


</body>
</html>