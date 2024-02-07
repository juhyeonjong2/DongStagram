package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SubController {

	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException ;
}
