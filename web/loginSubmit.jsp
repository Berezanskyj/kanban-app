<%-- 
    Document   : loginSubmit
    Created on : Nov 10, 2024, 3:01:19 AM
    Author     : berez
--%>
<%@page import="com.mysql.jdbc.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Driver"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
           String usuario = request.getParameter("usuario");
           String senha = request.getParameter("senha");

           Connection conecta = null;
           PreparedStatement st = null;
           ResultSet rs = null;
           String resposta = "";

           try {
               Class.forName("com.mysql.cj.jdbc.Driver");
               conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/kanbanapp", "root", "");

               st = conecta.prepareStatement("SELECT * FROM usuario WHERE usuario = ? AND senha = ?");
               st.setString(1, usuario);
               st.setString(2, senha);
               rs = st.executeQuery();

               // Verifica se o usuário foi encontrado
               if (rs.next()) {
                   resposta = "success";  // Resposta indicando sucesso
               } else {
                   resposta = "fail";  // Resposta indicando falha
               }
           } catch (ClassNotFoundException e) {
               resposta = "error";
               e.printStackTrace();
           } catch (SQLException e) {
               resposta = "error";
               e.printStackTrace();
           } finally {
               if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
               if (st != null) try { st.close(); } catch (SQLException ignore) {}
               if (conecta != null) try { conecta.close(); } catch (SQLException ignore) {}
           }

           // Envia a resposta simples para o AJAX (success, fail, ou error)
           out.print(resposta);
       %>