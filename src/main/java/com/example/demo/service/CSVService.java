package com.example.demo.service;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CSVRepository;
import com.example.demo.vo.Book;
import com.example.demo.vo.ChildZone;
import com.example.demo.vo.School;
import com.opencsv.CSVReader;

@Service
public class CSVService {

	@Autowired
	private CSVRepository csvRepository;

	public String readAndSaveToDB() {
		try {
			List<Book> csvList = new ArrayList<>();

			// 예시 파일들을 배열에 추가
			String[] fileNames = { "book1.csv", "book2.csv", "book3.csv", };

			for (String fileName : fileNames) {
				InputStream inputStream = getClass().getClassLoader().getResourceAsStream("CSV/" + fileName);
				if (inputStream != null) {
					InputStreamReader is = new InputStreamReader(inputStream, "EUC-KR");
					CSVReader reader = new CSVReader(is);
					// Remaining code for reading and processing the CSV file
				} else {
					System.err.println("File not found: " + fileName);
				}
			}

			for (String fileName : fileNames) {
				InputStreamReader is = new InputStreamReader(
						getClass().getClassLoader().getResourceAsStream("CSV/" + fileName), "EUC-KR");
				CSVReader reader = new CSVReader(is);

				// 첫 번째 줄(헤더) 건너뛰기
				reader.skip(1);

				List<String[]> list = reader.readAll();

				for (String[] csvRow : list) {
					Book book = new Book();
					// 엔터티의 필드에 CSV 데이터를 할당
					book.setCurriculum(csvRow[0]);
					book.setPublicationyear(Integer.parseInt(csvRow[1]));
					book.setStateswordrecognition(csvRow[2]);
					book.setDatatype(csvRow[3]);
					book.setSchoolLevel(csvRow[4]);
					book.setSchoolclassification(csvRow[5]);
					book.setTitle(csvRow[6]);
					book.setAuthor(csvRow[7]);
					book.setPublisher(csvRow[8]);
					book.setPrice(Double.parseDouble(csvRow[9]));
					book.setGrade(csvRow[10]);

					csvList.add(book);
				}
			}

			// CSV 데이터를 데이터베이스에 저장
			csvRepository.insertCSVList(csvList);

			return "CSV 데이터가 성공적으로 데이터베이스에 저장되었습니다.";

		} catch (Exception e) {
			e.printStackTrace();
			return "CSV 데이터를 데이터베이스에 저장하는 중 오류가 발생했습니다.";
		}
	}

	public String readAndSaveToDBchildzone() {
		try {
			List<ChildZone> csvList = new ArrayList<>();

			// 예시 파일들을 배열에 추가
			String[] fileNames = { "childzone.csv" };

			for (String fileName : fileNames) {
				InputStream inputStream = getClass().getClassLoader().getResourceAsStream("CSV/" + fileName);
				if (inputStream != null) {
					InputStreamReader is = new InputStreamReader(inputStream, "EUC-KR");
					CSVReader reader = new CSVReader(is);
					// Remaining code for reading and processing the CSV file
				} else {
					System.err.println("File not found: " + fileName);
				}
			}

			for (String fileName : fileNames) {
				InputStreamReader is = new InputStreamReader(
						getClass().getClassLoader().getResourceAsStream("CSV/" + fileName), "EUC-KR");
				CSVReader reader = new CSVReader(is);

				// 첫 번째 줄(헤더) 건너뛰기
				reader.skip(1);

				List<String[]> list = reader.readAll();

				for (String[] csvRow : list) {
					ChildZone childzone = new ChildZone();
					// 엔터티의 필드에 CSV 데이터를 할당
					childzone.setSchoolLevel(csvRow[0]);
					childzone.setFacilityname(csvRow[1]);
					childzone.setRoadaddress(csvRow[2]);
					childzone.setJibunaddress(csvRow[3]);
					childzone.setLatitude(Double.parseDouble(csvRow[4]));
					childzone.setLongitude(Double.parseDouble(csvRow[5]));
					childzone.setManagementagency(csvRow[6]);
					childzone.setPolice(csvRow[7]);
					childzone.setCctvinstallation(csvRow[8]);
					childzone.setCctvcount(csvRow[9]);
					childzone.setProtectedarea(csvRow[10]);
					childzone.setDatastandarddate(csvRow[11]);
					childzone.setProvidercode(Integer.parseInt(csvRow[12]));
					childzone.setProvidername(csvRow[13]);

					csvList.add(childzone);
				}
			}

			// CSV 데이터를 데이터베이스에 저장
			csvRepository.insertCSVListChildZone(csvList);

			return "CSV 데이터가 성공적으로 데이터베이스에 저장되었습니다.";

		} catch (Exception e) {
			e.printStackTrace();
			return "CSV 데이터를 데이터베이스에 저장하는 중 오류가 발생했습니다.";
		}
	}

	public String readAndSaveToDBSchool() {
		try {
			List<School> csvList = new ArrayList<>();

			// 예시 파일들을 배열에 추가
			String[] fileNames = { "school.csv" };

			for (String fileName : fileNames) {
				InputStream inputStream = getClass().getClassLoader().getResourceAsStream("CSV/" + fileName);
				if (inputStream != null) {
					InputStreamReader is = new InputStreamReader(inputStream, "EUC-KR");
					CSVReader reader = new CSVReader(is);
					// Remaining code for reading and processing the CSV file
				} else {
					System.err.println("File not found: " + fileName);
				}
			}

			for (String fileName : fileNames) {
				InputStreamReader is = new InputStreamReader(
						getClass().getClassLoader().getResourceAsStream("CSV/" + fileName), "EUC-KR");
				CSVReader reader = new CSVReader(is);

				// 첫 번째 줄(헤더) 건너뛰기
				reader.skip(1);

				List<String[]> list = reader.readAll();

				for (String[] csvRow : list) {
					School school = new School();
					// 엔터티의 필드에 CSV 데이터를 할당
					school.setSchoolID(csvRow[0]);
					school.setSchoolName(csvRow[1]);
					school.setSchoolLevel(csvRow[2]);
					school.setEstablishmentDate(csvRow[3]);
					school.setEstablishmentType(csvRow[4]);
					school.setClassification(csvRow[5]);
					school.setState(csvRow[6]);
					school.setJibunaddress(csvRow[7]);
					school.setRoadaddress(csvRow[8]);
					school.setEducationOfficeCode(Integer.parseInt(csvRow[9]));
					school.setEducationOffice(csvRow[10]);
					school.setEducationSupportOfficeCode(Integer.parseInt(csvRow[11]));
					school.setEducationSupportOffice(csvRow[12]);
					school.setLatitude(Double.parseDouble(csvRow[13]));
					school.setLongitude(Double.parseDouble(csvRow[14]));

					csvList.add(school);
				}
			}

			// CSV 데이터를 데이터베이스에 저장
			csvRepository.insertCSVListSchool(csvList);

			return "CSV 데이터가 성공적으로 데이터베이스에 저장되었습니다.";

		} catch (Exception e) {
			e.printStackTrace();
			return "CSV 데이터를 데이터베이스에 저장하는 중 오류가 발생했습니다.";
		}
	}
}