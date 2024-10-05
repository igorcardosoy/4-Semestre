package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.activities;

import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.Activity;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.Util;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.Writer;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ActivitiesWriter {

	private static final String path = Util.RESOURCES_PATH.getValue() + "/activities.json";

	public static Boolean write(Activity activity) {
		List<Activity> activities = ActivitiesReader.read();
		
		if(activities == null) {
			activities = new ArrayList<>();
			activity.setId(1L);
		}else {
			activity.setId(activities.getLast().getId() + 1);
		}

		activities.add(activity);

		return Writer.write(activities, path);
	}

	public static boolean update(Activity activity) {
		List<Activity> activities = ActivitiesReader.read();
		
		int index = 0;
		for(Activity a: activities) {
			if(Objects.equals(a.getId(), activity.getId())) {
				activities.set(index, activity);
			}
			index++;
		}
		
		return Writer.write(activities, path);
	}

	public static boolean delete(Activity activity) {
		List<Activity> activities = ActivitiesReader.read();

		activities.remove(activity);
		
		return Writer.write(activities, path);
	}
}








