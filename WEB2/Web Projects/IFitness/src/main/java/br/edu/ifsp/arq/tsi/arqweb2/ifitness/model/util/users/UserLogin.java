package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.users;

import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.User;

import java.util.List;

public class UserLogin {
	
	public static User login(String email, String password) {
		// ler o arquivo de usuários
		List<User> users = UsersReader.read();
		if(users != null) {
			for(User u: users) {
				if(u.getEmail().equals(email) && 
					u.getPassword().equals(
							PasswordEncoder.encode(password))) {
					return u;
				}
			}
		}
		return null;
	}

}





