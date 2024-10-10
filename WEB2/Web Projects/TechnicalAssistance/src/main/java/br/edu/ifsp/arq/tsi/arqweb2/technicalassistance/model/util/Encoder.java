package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Encoder {

	public static String encode(String message) {
		String messageEncrypted;
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			byte[] bytes = messageDigest.digest(message.getBytes());
			StringBuilder builder = new StringBuilder();
			for(byte b: bytes) {
				builder.append(String.format("%02X", b));
			}
			messageEncrypted = builder.toString();
		}catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Erro ao buscar algoritmo", e);
		}
		return messageEncrypted;
	}
}
