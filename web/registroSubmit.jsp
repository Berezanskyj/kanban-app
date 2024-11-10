<%-- 
    Document   : registroSubmit
    Created on : Nov 10, 2024, 1:33:43 AM
    Author     : berez
--%>
<%@page import="com.mysql.jdbc.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    
    <%
            String nome = request.getParameter("nome");
            String usuario = request.getParameter("usuario");
            String senha = request.getParameter("senha");

            Connection conecta = null;
            PreparedStatement st = null;
            String resposta = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/kanbanapp", "root", "");

                st = conecta.prepareStatement("INSERT INTO usuario (nome, usuario, senha) VALUES (?, ?, ?)");
                st.setString(1, nome);
                st.setString(2, usuario);
                st.setString(3, senha);
                st.executeUpdate();
                session.setAttribute("nome", nome);

                resposta = "Usuário cadastrado com sucesso!";
            } catch (ClassNotFoundException e) {
                resposta = "Erro: Driver JDBC não encontrado.";
                e.printStackTrace();
            } catch (SQLException e) {
                resposta = "Erro ao inserir dados no banco de dados.";
                e.printStackTrace();
            } finally {
                if (st != null) try { st.close(); } catch (SQLException ignore) {}
                if (conecta != null) try { conecta.close(); } catch (SQLException ignore) {}
            }

            // Envia apenas a resposta simples para o AJAX
            out.print(resposta);
        %>
