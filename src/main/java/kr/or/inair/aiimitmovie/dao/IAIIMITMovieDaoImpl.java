package kr.or.inair.aiimitmovie.dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IAIIMITMovieDaoImpl implements IAIIMITMovieDao {
	@Autowired
	private SqlMapClient client;

}
