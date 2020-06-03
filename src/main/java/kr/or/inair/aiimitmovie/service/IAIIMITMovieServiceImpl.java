package kr.or.inair.aiimitmovie.service;

import kr.or.inair.aiimitmovie.dao.IAIIMITMovieDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IAIIMITMovieServiceImpl implements IAIIMITMovieService {
	@Autowired
	private IAIIMITMovieDao aiIMITMovieDao;

}
