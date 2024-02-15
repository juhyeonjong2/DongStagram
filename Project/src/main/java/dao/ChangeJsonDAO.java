package dao;

import com.google.gson.Gson;

	public class ChangeJsonDAO {
	    public static void main(String[] args) {
	        String json = "[{\"name\":\"John\",\"age\":30},{\"name\":\"Emily\",\"age\":25}]";
	        Gson gson = new Gson();

	        // JSON 배열 파싱
	        Person[] persons = gson.fromJson(json, Person[].class);

	        System.out.println(persons[0]); 
	        
	        // 파싱된 결과 출력
	        for (Person person : persons) {
	            System.out.println("이름: " + person.getName());
	            System.out.println("나이: " + person.getAge());
	        }
	    }
	}

	class Person {
	    private String name;
	    private int age;
	    
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}


	}

