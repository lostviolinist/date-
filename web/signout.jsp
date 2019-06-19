<%
    session.invalidate();
    RequestDispatcher req = request.getRequestDispatcher("index.jsp");
    req.forward(request, response);
%>