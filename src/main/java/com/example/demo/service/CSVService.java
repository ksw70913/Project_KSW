package com.example.demo.service;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CSVRepository;
import com.example.demo.vo.Book;
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
}