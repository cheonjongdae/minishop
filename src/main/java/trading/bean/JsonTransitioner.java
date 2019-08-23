package trading.bean;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import product.bean.ProductDTO;

@Component
public class JsonTransitioner {

	//DB로 저장하기 위해 카트를 JSONString으로 변환
	public String makeListToJson(List<ProductDTO> cartList) {
		Gson gson = new GsonBuilder().create();
		return gson.toJson(cartList);}
	
	//웹으로 보내기 위해 카트를 JSONElement으로 변환
	public JsonElement makeListToJsonElement(List<ProductDTO> cartList) {
		Gson gson = new GsonBuilder().create();
		return gson.toJsonTree(cartList);}	
	
	//DB에 저장되어 있던 String을 List로 반환
	public List<ProductDTO> makeJsonToList(String json){
		Gson gson = new GsonBuilder().create();
		List<ProductDTO> cartList = gson.fromJson(json, new TypeToken<ArrayList<ProductDTO>>() {}.getType());
		return cartList;}
}