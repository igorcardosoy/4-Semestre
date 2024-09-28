package br.edu.ifsp.ifitness.model.util.activities;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import br.edu.ifsp.ifitness.model.util.Util;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import br.edu.ifsp.ifitness.model.Activity;
import br.edu.ifsp.ifitness.model.util.LocalDateTypeAdapter;

public class ActivitiesWriter {

	public static Boolean write(Activity activity) {
		Gson gson = new GsonBuilder()
				.registerTypeAdapter(LocalDate.class, 
						new LocalDateTypeAdapter())
				.create();
		List<Activity> activities = ActivitiesReader.read();
		String path = Util.RESOURCES_PATH.getValue() + "/activities.json";
		
		if(activities == null) {
			// quando não tem nenhum objeto cadastrado
			activities = new ArrayList<>();
			activity.setId(1L);
		}else {
			// definir o id
			activity.setId(activities.get(activities.size() -1).getId() + 1);
		}
		
		// adicionar na lista
		activities.add(activity);
		
		// converte para o formato JSON
		String json = gson.toJson(activities);
		
		// escrever no arquivo
		try {
			FileWriter writer = new FileWriter(path);
			writer.write(json);
			writer.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return true;
	}

	public static boolean update(Activity activity) {
		Gson gson = new GsonBuilder()
				.registerTypeAdapter(LocalDate.class, 
						new LocalDateTypeAdapter())
				.create();
		List<Activity> activities = ActivitiesReader.read();
		String path = Util.RESOURCES_PATH.getValue() + "/activities.json";
		
		int index = 0;
		for(Activity a: activities) {
			if(a.getId() == activity.getId()) {
				activities.set(index, activity);
			}
			index++;
		}
		
		// converte para o formato JSON
		String json = gson.toJson(activities);
		
		// escrever no arquivo
		try {
			FileWriter writer = new FileWriter(path);
			writer.write(json);
			writer.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return true;
	}

	public static boolean delete(Activity activity) {
		Gson gson = new GsonBuilder()
				.registerTypeAdapter(LocalDate.class, 
						new LocalDateTypeAdapter())
				.create();
		List<Activity> activities = ActivitiesReader.read();
		String path = "/media/Documentos/Fernando/ARQWEB1/WorkspaceEclipse/activities.json";
		
		activities.remove(activity);
		
		// converte para o formato JSON
		String json = gson.toJson(activities);
		
		// escrever no arquivo
		try {
			FileWriter writer = new FileWriter(path);
			writer.write(json);
			writer.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return true;
	}
}








