/*
 *    GeoAPI - Java interfaces for OGC/ISO standards
 *    Copyright © 2003-2023 Open Geospatial Consortium, Inc.
 *    http://www.geoapi.org
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.opengis.referencing.operation;

import java.util.Map;
import java.util.List;
import org.opengis.annotation.UML;

import static org.opengis.annotation.Obligation.*;
import static org.opengis.annotation.Specification.*;


/**
 * An ordered sequence of two or more single coordinate operations. The sequence of operations is
 * constrained by the requirement that the source coordinate reference system of step
 * (<var>n</var>+1) must be the same as the target coordinate reference system of step
 * (<var>n</var>). The source coordinate reference system of the first step and the target
 * coordinate reference system of the last step are the source and target coordinate reference
 * system associated with the concatenated operation. Instead of a forward operation, an inverse
 * operation may be used for one or more of the operation steps mentioned above, if the inverse
 * operation is uniquely defined by the forward operation.
 *
 * @author  Martin Desruisseaux (IRD)
 * @version 3.0
 * @since   1.0
 *
 * @see CoordinateOperationFactory#createConcatenatedOperation(Map, CoordinateOperation[])
 */
@UML(identifier="CC_ConcatenatedOperation", specification=ISO_19111, version=2007)
public interface ConcatenatedOperation extends CoordinateOperation {
    /**
     * Returns the sequence of operations.
     * The sequence can contain {@link SingleOperation}s or {@link PassThroughOperation}s,
     * but should not contain other {@code ConcatenatedOperation}s.
     *
     * <div class="warning"><b>Upcoming API change</b><br>
     * This method is conformant to ISO 19111:2003. But the ISO 19111:2007 revision changed the element type
     * from {@code SingleOperation} to {@link CoordinateOperation}. This change may be applied in GeoAPI 4.0.
     * This is necessary for supporting usage of {@code PassThroughOperation} with {@link ConcatenatedOperation}.
     * </div>
     *
     * @return the sequence of operations.
     */
    @UML(identifier="coordOperation", obligation=MANDATORY, specification=ISO_19111)
    List<SingleOperation> getOperations();
}
