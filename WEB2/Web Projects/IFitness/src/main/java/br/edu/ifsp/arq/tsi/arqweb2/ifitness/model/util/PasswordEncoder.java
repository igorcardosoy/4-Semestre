package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordEncoder {

	public static String encode(String password) {
		String passwordEncrypted;
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			byte[] bytes = messageDigest.digest(password.getBytes());
			StringBuilder builder = new StringBuilder();
			for(byte b: bytes) {
				builder.append(String.format("%02X", b));
			}
			passwordEncrypted = builder.toString();
		}catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Erro ao buscar algoritmo", e);
		}
		return passwordEncrypted;
	}
}
