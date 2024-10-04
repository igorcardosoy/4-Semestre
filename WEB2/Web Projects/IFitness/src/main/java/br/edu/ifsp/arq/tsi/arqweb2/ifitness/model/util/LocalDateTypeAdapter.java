package br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util;

import com.google.gson.*;

import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateTypeAdapter implements
	JsonSerializer<LocalDate>, JsonDeserializer<LocalDate>{
	
	private final DateTimeFormatter formatter =
			DateTimeFormatter.ofPattern("yyyy-MM-dd");

	@Override
	public LocalDate deserialize(JsonElement json, Type type, 
			JsonDeserializationContext context)
			throws JsonParseException {
		return LocalDate.parse(json.getAsString(), formatter);
	}

	@Override
	public JsonElement serialize(LocalDate date, Type type, 
			JsonSerializationContext context){
		return new JsonPrimitive(date.format(formatter));
	}

}






