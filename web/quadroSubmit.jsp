<%-- 
    Document   : quadroSubmit
    Created on : Nov 11, 2024, 11:51:48 PM
    Author     : berez
--%>

<%@page import="com.mysql.jdbc.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



 <%
        //CADASTRANDO CARD NO BANCO DE DADOS.
        String descricao = request.getParameter("descricao");
        String prioridade = request.getParameter("prioridade");
        String prazo = request.getParameter("prazo");
        String coluna = request.getParameter("coluna");
     
     
            Connection conecta = null;
            PreparedStatement st = null;
            String resposta = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/kanbanapp", "root", "");

                st = conecta.prepareStatement("INSERT INTO tarefas (descricao, prioridade, prazo, coluna) VALUES (?, ?, ?, ?)");
                st.setString(1, descricao);
                st.setString(2, prioridade);
                st.setString(3, prazo);
                st.setString(4, coluna);
                st.executeUpdate();
                
                response.sendRedirect("quadro.jsp");

            } catch (ClassNotFoundException e) {
                resposta = "Erro: Driver JDBC não encontrado.";
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (st != null) try { st.close(); } catch (SQLException ignore) {}
                if (conecta != null) try { conecta.close(); } catch (SQLException ignore) {}
            }
%>