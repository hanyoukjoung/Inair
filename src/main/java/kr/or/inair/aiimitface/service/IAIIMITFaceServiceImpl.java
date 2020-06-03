package kr.or.inair.aiimitface.service;
import kr.or.inair.aiimitface.dao.IAIIMITFaceDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IAIIMITFaceServiceImpl implements IAIIMITFaceService {
	@Autowired
	private IAIIMITFaceDao aiIMITFaceDao;

}
