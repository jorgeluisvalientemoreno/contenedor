using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    public class ContainerCollections
    {
        private static ContainerCollections _instance = null;
        private List<ContainerArticle> _collectionArticles;
        private List<ContainerSubLine> _collectionSubLines;
        private List<ContainerSublineByLine> _collectionSublinesByLine;


        /// <summary>
        /// Colecciòn de articulos
        /// </summary>
        public List<ContainerArticle> CollectionArticles
        {
            get { return _collectionArticles; }
            set { _collectionArticles = value; }
        }

        /// <summary>
        /// Colecciòn de SubLineas
        /// </summary>
        public List<ContainerSubLine> CollectionSubLines
        {
            get { return _collectionSubLines; }
            set { _collectionSubLines = value; }
        }

        /// <summary>
        /// Colecciòn de SubLineas por Línea
        /// </summary>
        public List<ContainerSublineByLine> CollectionSublinesByLine
        {
            get { return _collectionSublinesByLine; }
            set { _collectionSublinesByLine = value; }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static ContainerCollections GetInstance()
        {

            if (_instance == null)
                _instance = new ContainerCollections();
            return _instance;

        }

        public void Destroy()
        {
            _instance = null;
        }



    }
}
